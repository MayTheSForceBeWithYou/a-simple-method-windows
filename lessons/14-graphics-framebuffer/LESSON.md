# Lesson 14 — Graphics: Framebuffer and PPM Output

Lesson 13 gave you Q16.16 for smooth motion. This lesson gives you **pixels**: a flat byte buffer, a store at an address, a fill loop, a block copy, a color-key copy that skips zeros, and a P6 PPM file written with `CreateFileA`, `WriteFile`, and `CloseHandle`. No device mapping, no GUI toolkit, no C runtime.

Every listing is a complete MASM program. Status is ECX to `ExitProcess`. Build from an x64 Native Tools prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

Listing `05-write-ppm-p6` is the one that allocates shadow space and emits unwind codes (`PROC FRAME`, `.pushreg`, `.allocstack`, `.endprolog`). The first four listings call `ExitProcess` without that prologue.

## What this lesson asks of you

Treat a framebuffer as `width * height * bytes_per_pixel` bytes (listing `01-pixel-plot` reserves `640*480*4`). Store a color at an address you compute — the plot listing writes the first dword and exits 0; the general formula is still `y * pitch + x * bytes_per_pixel`. Fill a run of pixels. Copy a sprite with `rep movsd` (DF must be 0). Skip key-color source bytes so the destination keeps what it had. Write a P6 header and 3-byte RGB triples through Win32, not through a raw `syscall`.

## Why a framebuffer for the game milestone

Lessons 16–18 draw into a buffer and write a file (or, later, a window). The Jack listings isolate four stores and one file write so you can see each contract: a single dword, a counted fill, a string-move blit, a keyed blit that sums what landed, and a PPM that exits 0 on success.

## Pixel offset, pitch, and packing (formula, then the plot listing)

A framebuffer is a flat `DB` array. Pixel `(x, y)` lives at:

```
offset = y * pitch + x * bytes_per_pixel
```

**Pitch** (stride) is the byte distance from one row to the next. It is at least `width * bytes_per_pixel`, and hardware often pads it up to a power-of-two boundary: `aligned = (raw + align - 1) AND (NOT (align - 1))`.

**Bytes per pixel.** These listings use 4 (a DWORD per pixel) except the keyed blit and the PPM payload (1 and 3). P6 files are always 3 bytes per pixel, R then G then B, no padding.

**Packing.** `(R SHL 16) OR (G SHL 8) OR B` in a register is `00RRGGBBh`. x86-64 is little-endian, so a `mov DWORD PTR` stores B, G, R, 0 in memory. Dumping that dword into a P6 file writes the channels backwards plus a pad byte. Write R, G, B as three bytes.

Listing `06-pitch-pixel-offset` computes the formula with `y = 1`, `pitch = 32`, `x = 2`, `bpp = 4` (`shl rbx, 2`). `1 * 32 + 2 * 4 = 40`. Expected exit: **40**. RBX is saved: `push rbx` / `sub rsp, 32`. There is still no listing that pads pitch to an alignment boundary.

```asm
; Listing 06: y*pitch + x*bpp pixel offset
; Expected exit: 40
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    mov     rax, 1
    mov     rbx, 32
    imul    rax, rbx
    mov     rbx, 2
    shl     rbx, 2
    add     rax, rbx
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

Listing `07-rgb-pack-low-byte` packs R=1, G=2, B=3: `eax = 1 SHL 16`, `or` in `2 SHL 8`, `or` in 3, then `and eax, 0FFh` so only the blue channel remains. Expected exit: **3**. The packed dword before the mask is `00010203h`.

```asm
; Listing 07: Pack R,G,B into dword; exit blue channel
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, 1
    shl     eax, 16
    mov     ebx, 2
    shl     ebx, 8
    or      eax, ebx
    or      eax, 3
    and     eax, 0FFh
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

Listing `01-pixel-plot` does **not** compute that offset. It `lea rax, fb` and writes `0FFFFFFFFh` at `[rax]` — pixel (0, 0), all bits 1. Then it zeros ECX. Status **0**. The reservation is `640*480*4` bytes in `.DATA?` (zeroed at load). The store is the plot; the address is the base.

```asm
; Listing rule: any rep movs* user must run cld before the op and before ret (DF clear at ABI entry/return only).
; Expected exit: 0
; Expected stdout: (none)
; Plot pixel at (x,y) in framebuffer, exit 0
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rax, fb
    mov DWORD PTR [rax], 0FFFFFFFFh
    xor ecx, ecx
    call ExitProcess
main ENDP
END
```

## Fill a linear run

Listing `02-fill-rect` is named as a rectangle. The body is a 1-D loop: RDI starts at `fb`, ECX = 100, each iteration writes `0FF0000FFh` and adds 4, `loop fill_loop`. One hundred consecutive dwords, not a 2-D `width × height` nest and not a pitch add between rows. Status **0**.

`0FF0000FFh` in memory is bytes `FFh, 00h, 00h, FFh` (little-endian). If you read that as 8-bit B, G, R, A you get blue and opaque alpha; if you read it as A, R, G, B you get alpha `FFh` and blue `FFh`.

```asm
; Listing rule: any rep movs* user must run cld before the op and before ret (DF clear at ABI entry/return only).
; Expected exit: 0
; Expected stdout: (none)
; Fill rectangle with color, exit 0
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rdi, fb
    mov ecx, 100
fill_loop:
    mov DWORD PTR [rdi], 0FF0000FFh
    add rdi, 4
    loop fill_loop
    xor ecx, ecx
    call ExitProcess
main ENDP
END
```

RDI is nonvolatile. This is `main` plus `ExitProcess`. `loop` uses RCX as the count; after the last iteration RCX is 0, and the listing still does `xor ecx, ecx` before the call.

## Blit: `rep movsd`

A **blit** (block transfer) copies a rectangle from source to destination. Listing `03-blit-copy` copies four dwords `1, 2, 3, 4` from `sprite` into `fb` with `rep movsd`. RSI = source, RDI = dest, ECX = 4. Status **0**. It does not sum the pixels.

`movsd` copies 4 bytes from `[rsi]` to `[rdi]` and steps both by 4 (DF = 0) or −4 (DF = 1). `rep` repeats ECX times. Lesson 06 required `cld` before `rep movsb`. This listing has no `cld`. A Windows process starts with DF = 0 in normal cases; a preceding `std` would make this copy walk backward and smash memory before `fb`. Put `cld` in any blit you reuse.

RSI and RDI are nonvolatile. Again, this entry point does not return.

```asm
; Listing rule: code using rep movs* must run cld before the string op and before ret
; Expected exit: 0
; Expected stdout: (none)
; (MS x64 ABI guarantees DF clear on function entry and return; do not assume DF=0 across calls).
;
; Copy sprite to framebuffer, exit 0
.DATA
sprite DD 1, 2, 3, 4
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rsi, sprite
    lea rdi, fb
    mov ecx, 4
    rep movsd
    xor ecx, ecx
    call ExitProcess
main ENDP
END
```

## Color-key blit: skip zeros, then sum

A **color-key blit** skips source pixels that match a transparent key (here, 0). Listing `04-blit-key-copy` walks four bytes of `src DB 0, 5, 0, 5, 0` (the fifth 0 is unused). After `lea r10, src` and `lea r11, dst`, each load/store is `[r10+rcx]` / `[r11+rcx]`. On a zero it jumps past the store. `dst` is `.DATA?`, so skipped slots stay 0. After the copy, `dst` is `0, 5, 0, 5`. The sum loop adds those four bytes: 10. Status **10**.

```asm
; Listing rule: any rep movs* user must run cld before the op and before ret (DF clear at ABI entry/return only).
; Listing 04: Color-key blit copy loop (LESSON.md block 4)
; Expected exit: 10
; Expected stdout: (none)

.DATA
src DB 0, 5, 0, 5, 0

.DATA?
dst DB 4 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, src
    lea     r11, dst
    xor     rcx, rcx
copy_loop:
    cmp     rcx, 4
    jge     done
    mov     al, BYTE PTR [r10+rcx]
    test    al, al
    jz      skip
    mov     BYTE PTR [r11+rcx], al
skip:
    inc     rcx
    jmp     copy_loop
done:
    xor     rax, rax
    mov     rcx, 4
sum_loop:
    dec     rcx
    js      exit_sum
    movzx   rdx, BYTE PTR [r11+rcx]
    add     rax, rdx
    jmp     sum_loop
exit_sum:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

The zeros in `dst` are not writes of the key. They are bytes the loop never touched. If `dst` had held `9, 9, 9, 9`, the result would be `9, 5, 9, 5`. That is the point of a key: the background shows through. Lesson 16's sprites depend on it.

## P6 PPM through Win32

A **P6 PPM** file is:

1. An ASCII header: `P6`, newline, `width height`, newline, `255`, newline.
2. Binary pixels: 3 bytes each, R then G then B, row-major, no row pad.

Listing `05-write-ppm-p6` builds that file as `out.ppm`.

`hdr DB "P6", 10, "4 2", 10, "255", 10` is 11 bytes. `HLEN EQU $ - hdr` is that 11. `$` is the assembler's current address; `$ - path` would be the distance from the path label, which is the wrong length.

After `lea r10, px`, the paint loop writes 255 at `[r10+rcx]` for RCX = 0, 3, 6, …, 21 — the red byte of each of eight pixels (4 × 2). Green and blue stay 0 because `px` is `.DATA?`. The image is solid red.

Then the Win32 sequence (lesson 08):

| Call | RCX | RDX | R8 | R9 | stack |
|------|-----|-----|----|----|-------|
| `CreateFileA` | `path` | `40000000h` (`GENERIC_WRITE`) | 0 share | 0 security | disposition `2` (`CREATE_ALWAYS`), attributes `80h` (`FILE_ATTRIBUTE_NORMAL`), template 0 |
| `WriteFile` | HANDLE | `hdr` | `HLEN` | `&bytesWritten` | overlapped 0 |
| `WriteFile` | HANDLE | `px` | 24 | `&bytesWritten` | overlapped 0 |
| `CloseHandle` | HANDLE | | | | |
| `ExitProcess` | 0 or 1 | | | | |

`CreateFileA` failure is RAX = −1 (`INVALID_HANDLE_VALUE`), not 0. The listing compares to −1 and exits **1** on failure. Success falls through both writes, closes, and exits **0**.

The prologue is `PROC FRAME`, `push rbx` / `.pushreg rbx`, `sub rsp, 64` / `.allocstack 64`, `.endprolog`. RBX holds the HANDLE across calls (RBX is nonvolatile). 64 bytes covers 32 bytes of shadow space plus the three stack arguments to `CreateFileA`. There is no `.setframe`: that directive exists when you set a frame-pointer register (usually RBP). This listing does not.

```asm
; Listing rule: any rep movs* user must run cld before the op and before ret (DF clear at ABI entry/return only).
; Listing 05: Write P6 PPM via Win32 (LESSON.md block 5)
; Expected exit: 0
; Expected stdout: (none)

.DATA
path DB "out.ppm", 0
hdr DB "P6", 10, "4 2", 10, "255", 10
HLEN EQU $ - hdr

.DATA?
px DB 24 DUP(?)
bytesWritten DWORD ?
hFile QWORD ?

.CODE
EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 64
    .allocstack 64
    .endprolog

    lea     r10, px
    xor     rcx, rcx
paint:
    cmp     rcx, 24
    jge     write_file
    mov     BYTE PTR [r10+rcx], 255
    add     rcx, 3
    jmp     paint

write_file:
    lea     rcx, path
    mov     edx, 40000000h
    xor     r8d, r8d
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 2
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    cmp     rax, -1
    je      fail
    mov     rbx, rax

    mov     rcx, rbx
    lea     rdx, hdr
    mov     r8d, HLEN
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    lea     rdx, px
    mov     r8d, 24
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    call    CloseHandle

    xor     ecx, ecx
    call    ExitProcess

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
```

Write R, G, B as three bytes. Do not `WriteFile` the packed dword `00RRGGBBh` — little-endian would emit B, G, R, 0.

### Clip, Sleep pacing, and Bresenham

Clipping uses half-open tests: a coordinate is inside when `x >= lo && x < hi` (and the same for y). Width is the first outside column. A blit that ignores that writes off the end of `fb`. There is still no listing for double-buffer flip, alpha, or damage rects.

Listing `08-clip-half-open` loads `x = 5` and compares to 4. The in-range label is `jl in_range` — that is `x < 4` only; there is no `x >= 0` check. 5 is not less than 4, so it takes `mov ecx, 1`. Expected exit: **1** (outside). The in-range path would exit 0. The comparison form for a full half-open clip against `[0, 4)` is `x >= 0 && x < 4`.

```asm
; Listing 08: Half-open clip test x in [0, width)
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 5
    cmp     rax, 4
    jl      in_range
    mov     ecx, 1
    jmp     done
in_range:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
```

Listing `09-vsync-ready-flag` is **not** a display vsync. The prologue is `main PROC FRAME` with `sub rsp, 40` / `.allocstack 40` (no `push rbx`). The loop does `mov ecx, 1` / `call Sleep` / `inc ebx` / `cmp ebx, 3` / `jl frame_wait_loop`. Three completed `Sleep(1)` calls leave EBX = 3. Expected exit: **3**. That is three millisecond sleeps for CI, not a QPC spin, not a vertical-blank interrupt, and not `DwmFlush`.

```asm
; Listing 09: Frame pacing with Sleep (three 1ms waits)
; Expected exit: 3
; Expected stdout: (none)
;
; Completes three frame waits; exit code equals the wait count.

.CODE
EXTRN Sleep:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog

    xor     ebx, ebx

frame_wait_loop:
    mov     ecx, 1
    call    Sleep
    inc     ebx
    cmp     ebx, 3
    jl      frame_wait_loop

    mov     ecx, ebx
    call    ExitProcess
main ENDP
END
```

Listing `10-bresenham-pixel-count` walks from (0, 0) to (3, 2). `delta_x = 3`, `delta_y = 2`, `err = 2*delta_y - delta_x = 1`. Each loop iteration increments `count`, then stops when `x == delta_x`. That plots x in `x >= 0 && x <= 3` — four columns. The y-step happens when `err > 0` (`test` / `jle no_y_step`). Expected exit: **4**. RBX is saved: `push rbx` / `sub rsp, 40`.

```asm
; Listing 10: Bresenham line from (0,0) to (3,2); count plotted points
; Expected exit: 4
; Expected stdout: (none)
;
; delta_x=3 delta_y=2; err starts at 2*delta_y-delta_x=1; plot each x in [0..3] (four columns).

.DATA?
x QWORD ?
y QWORD ?
delta_x QWORD ?
delta_y QWORD ?
err QWORD ?
count QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 40
    mov     x, 0
    mov     y, 0
    mov     delta_x, 3
    mov     delta_y, 2
    mov     rax, delta_y
    shl     rax, 1
    sub     rax, delta_x
    mov     err, rax
    mov     count, 0

bres_loop:
    inc     count
    mov     rax, x
    cmp     rax, delta_x
    je      bres_done
    mov     rax, err
    mov     rbx, delta_y
    shl     rbx, 1
    add     rax, rbx
    mov     err, rax
    test    rax, rax
    jle     no_y_step
    inc     y
    mov     rbx, delta_x
    shl     rbx, 1
    sub     rax, rbx
    mov     err, rax
no_y_step:
    inc     x
    jmp     bres_loop

bres_done:
    add     rsp, 40
    pop     rbx
    sub     rsp, 40
    mov     rcx, count
    mov     ecx, ecx
    call    ExitProcess
main ENDP
END
```

## Worked example: what the keyed blit leaves behind

**Task.** Listing `04-blit-key-copy` copies `0, 5, 0, 5` into a `.DATA?` destination, skipping zeros. Why is the status 10, and would writing the zeros have changed that number?

**Loop.** RCX = 0..3. `src[0]` is 0 → skip. `src[1]` is 5 → store. `src[2]` is 0 → skip. `src[3]` is 5 → store. Sum = 0+5+0+5 = 10.

**Plausible wrong reading.** *"Key 0 means 'write transparent,' so the blit stores 0 into those slots, and that is why the sum is 10."*

**Why it fails.** `jz skip` jumps **over** `mov BYTE PTR dst[rcx], al`. Nothing is written on a key hit. The zeros in `dst` are the loader's zeros. A destination that started as `3, 3, 3, 3` would become `3, 5, 3, 5` (sum 16). The status 10 cannot tell "wrote 0" from "left 0." The comment in the listing says exit 10; that 10 is the sum of the two stored fives.

**The correct reading.** A keyed blit leaves the destination pixel untouched where the source matches the key.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| Pitch equals width | Pitch is `width * bytes_per_pixel`, plus optional pad. Offset uses pitch, not width. |
| Listing 01 computes `y * pitch + x * 4` | Listing 01 stores at `[fb+0]` and exits 0. Listing `06-pitch-pixel-offset` is `1*32 + 2*4` and exits **40**. |
| Listing 02 fills a 2-D rectangle | It writes 100 consecutive dwords. Status 0. |
| Packed `00RRGGBBh` is R,G,B in memory | Little-endian stores B, G, R, 0. P6 wants R, G, B as three bytes. |
| Color-key blit writes 0 | It skips the store. Listing 04 exits 10. |
| P6 accepts 4 bytes per pixel | P6 is 3 bytes, no alpha, no row pad. Listing 05 writes 24 bytes for 4×2. |
| File I/O is `mov rax, 1` / `syscall` | Listing 05 calls `CreateFileA` / `WriteFile` / `CloseHandle` with RCX, RDX, R8, R9, and `[rsp+32]`. |
| `.setframe` is required on every `FRAME` proc | `.setframe` records a frame-pointer register. Listing 05 has FRAME and no RBP frame; `.pushreg` + `.allocstack` are enough. |

## Check yourself

1. Listing `01-pixel-plot` writes `0FFFFFFFFh` at the base of a 640×480×4 buffer. What `(x, y)` is that, and what status does the process return?
2. You store packed `00010203h` (R=1, G=2, B=3) with one `mov DWORD PTR`. List the four memory bytes. Why is that sequence wrong for P6?
3. Listing `04-blit-key-copy`: blit `0, 7, 0, 7` into destination `3, 3, 3, 3` with key 0. What four bytes remain?
4. Listing `05-write-ppm-p6`: what is `HLEN`, and why is `$ - path` the wrong length?
5. A 100-pixel-wide buffer, 4 bytes per pixel, rows aligned to 128 bytes: what is the pitch?

## Key takeaways

- Offset is `y * pitch + x * bpp`. Listing `06-pitch-pixel-offset` exits **40**. Listing 01 plots at the base and exits 0. Listing `07-rgb-pack-low-byte` packs 1,2,3 and exits blue **3**.
- Listing 02 fills 100 dwords with `0FF0000FFh` and exits 0. It is a linear run, not a pitched rectangle.
- `rep movsd` copies dwords; DF must be 0. Listing 03 exits 0 and does not sum.
- A keyed blit skips the key. Listing 04 exits 10, the sum of the two stored fives.
- P6 is an 11-byte header plus 3-byte RGB. Listing 05 uses Win32 file calls and exits 0 on success, 1 if `CreateFileA` returns −1.
- Little-endian dword stores are not P6 channel order.
- Half-open clip is `x >= lo && x < hi`. Listing `08-clip-half-open` tests only `x < 4` for x=5 and exits **1** (outside).
- Listing `09-vsync-ready-flag` exits **3** after three `Sleep(1)` calls — not a display vsync and not a QPC spin.
- Listing `10-bresenham-pixel-count` plots four columns from (0,0) to (3,2) and exits **4**.

## Lookup

- PPM: [Netpbm PPM specification](http://netpbm.sourceforge.net/doc/ppm.html)
- Endianness: [Endianness](https://en.wikipedia.org/wiki/Endianness)
- Stride: [Stride of an array](https://en.wikipedia.org/wiki/Stride_of_an_array)
- `CreateFileA` / `WriteFile` / `CloseHandle`: lesson 08; [CreateFileA](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea)
- Microsoft x64: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- Unwind: `.pushreg`, `.allocstack`, `.setframe`, `.endprolog` — [x64 exception handling](https://learn.microsoft.com/en-us/cpp/build/exception-handling-x64)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

Addressing: pixel offset, pack RGB (low byte is B), stride, `put_pixel`, framebuffer size shifted for an 8-bit status.

Fill and copy: clear, plot/readback, blit copy, row fill, hline, vline, rect fill, keyed blit.

Clip: half-open `[0, width)`. P6 header length. Stubs for vsync, double-buffer index, alpha, damage, Bresenham count.
