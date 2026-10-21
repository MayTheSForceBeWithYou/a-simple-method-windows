# Lesson 18 — Capstone: Park Simulation

Lesson 17 gave you entities, a heuristic, and a wrap-around focus index. This capstone composes those primitives with a tile grid, a parent-array walk, an economy qword that must not go negative, and a binary save/load path that uses `CreateFileA`, `WriteFile`, `ReadFile`, and `CloseHandle`. By the end you treat “the park sim” as those concrete listings linked together, not as a framework.

Windows file I/O is the lesson 08 contract: arguments in RCX / RDX / R8 / R9 and `[rsp+32]…`, 32 bytes of shadow space, HANDLE −1 on `CreateFileA` failure, BOOL in RAX for `WriteFile` / `ReadFile` / `CloseHandle`.

## What this lesson asks of you

You spawn by incrementing a visitor counter. You treat an empty A* listing as status 0, not as a search. You validate an 8-byte header against a DWORD magic and a DWORD version, and you can decode what `"PK01"` actually is in little-endian. You reserve an 8×8 map in `.DATA?` and you clamp an x of 99 into `[0, width)` two ways (signed then unsigned), both of which exit 7. You walk `parent[pos]` one hop. You subtract upkeep from cash only after an unsigned compare, and you can show why an unguarded `sub` is not that compare. You write `park.sav` with `CreateFileA` / `WriteFile` / `CloseHandle` and you load a header with a missing-file harness that still exits 1.

## Acceptance criteria (what “done” means)

The park binary is done when all of these hold:

1. **Multi-file build.** `main`, map, economy, and save are separate `.asm` files with `PUBLIC` / `EXTRN`, linked with `link.exe` and `kernel32.lib`. No unresolved externals.
2. **Map and pieces.** An 8×8 (or larger) byte grid holds path and at least three track types. Indices are clamped **before** they become addresses.
3. **One agent walks a path.** BFS or A* produces a `parent[]` array; each tick does `pos = parent[pos]` until `pos == goal`.
4. **Cash never goes negative.** Each tick adds income and subtracts upkeep only when `cash >= upkeep` (unsigned compare, then `sub`).
5. **Save / load with a header.** Eight bytes: four-byte magic plus a version DWORD, then `width * height` map bytes. Reject a bad magic or a wrong version.
6. **Visible state.** A P6 PPM of the map (lesson 14) or another file the user can open. The sim does not need `/dev/fb0`.

The Jack listings isolate those primitives. They are not the whole binary.

### Track connect, 100 ticks, and a 2×2 P6 map

Listing `13-track-piece-connect` encodes a four-way direction wrap. Directions are 0..3. The opposite of a facing is `(facing + 2) AND 3`. Here the piece heading is 1 and the neighbor facing is 3: `(3 + 2) AND 3 = 1`, which matches. Expected exit: **1**. A mismatch would exit 0. RBX is saved: `push rbx` / `sub rsp, 32`.

```asm
; Listing 13: Track piece direction connect rule
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    mov     rax, 1
    mov     rbx, 3
    mov     rcx, rbx
    add     rcx, 2
    and     rcx, 3
    cmp     rax, rcx
    je      connected
    xor     ecx, ecx
    jmp     done
connected:
    mov     ecx, 1
done:
    call    ExitProcess
main ENDP
END
```

Listing `14-hundred-tick-loop` zeros `tick` and `accum`, then while `tick < 100` adds 1 to `accum` and increments `tick`. One hundred iterations leave `accum = 100`. Expected exit: **100**. The compare is `tick >= 100` to stop, i.e. the body runs for `tick` in `tick >= 0 && tick < 100`.

```asm
; Listing 14: Fixed 100-tick simulation loop with per-tick work
; Expected exit: 100
; Expected stdout: (none)

.DATA?
tick QWORD ?
accum QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     tick, 0
    mov     accum, 0

tick_loop:
    cmp     tick, 100
    jge     tick_done
    add     accum, 1
    inc     tick
    jmp     tick_loop

tick_done:
    mov     ecx, DWORD PTR accum
    call    ExitProcess
main ENDP
END
```

Listing `15-render-map-p6` writes `map.ppm`. The header is `"P6\n2 2\n255\n"` — `HLEN EQU $ - hdr` is 11. The payload is 12 RGB bytes (2×2 pixels). `CreateFileA` uses `GENERIC_WRITE` (`40000000h`) and disposition 2 (`CREATE_ALWAYS`). Two `WriteFile`s add into `totalWritten`. On success that sum is 11 + 12 = 23. Expected exit: **23**. `CreateFileA` or `WriteFile` failure exits **1**.

```asm
; Listing 15: Write 2x2 map as P6 PPM (LESSON.md)
; Expected exit: 23
; Expected stdout: (none)
; Expected side effect: creates map.ppm (11-byte P6 header + 12 RGB bytes = 23 written)

.DATA
path DB "map.ppm", 0
hdr DB "P6", 10, "2 2", 10, "255", 10
HLEN EQU $ - hdr
map_cells BYTE 255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 0
PIXEL_BYTES EQU 12
TOTAL_BYTES EQU HLEN + PIXEL_BYTES

.DATA?
bytesWritten DWORD ?
hFile QWORD ?
totalWritten DWORD ?

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

    mov     totalWritten, 0

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
    test    rax, rax
    jz      fail_close
    add     totalWritten, bytesWritten

    mov     rcx, rbx
    lea     rdx, map_cells
    mov     r8d, PIXEL_BYTES
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile
    test    rax, rax
    jz      fail_close
    add     totalWritten, bytesWritten

    mov     rcx, rbx
    call    CloseHandle

    mov     ecx, DWORD PTR totalWritten
    call    ExitProcess

fail_close:
    mov     rcx, rbx
    call    CloseHandle

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
```

## Spawn a visitor

Listing `01-visitor-spawn` zeros `visitor_count`, increments it, and exits the new count. Expected exit: **1**.

```asm
; Spawn visitor entity, exit visitor count
.DATA?
visitor_count QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov visitor_count, 0
    inc visitor_count
    mov rax, visitor_count
    mov ecx, eax
    call ExitProcess
main ENDP
END

```

A real spawn also writes the new id into a SoA slot (lesson 17) and sets `alive`. This listing is the counter.

## Pathfinding step as a stub

Listing `02-pathfind-step` reserves `open_list` and `closed_list` (16 QWORDs each) and exits 0. There is no push, no pop, no heuristic. Expected exit: **0**.

```asm
; One A* pathfinding step, exit 0
.DATA?
open_list QWORD 16 DUP(?)
closed_list QWORD 16 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    xor ecx, ecx
    call ExitProcess
main ENDP
END

```

The walk you actually run each tick is listing `07-agent-parent-step` below. A*’s open/closed sets are not implemented here.

## Map grid in BSS

Listing `04-map-grid-bss` defines `width EQU 8`, `height EQU 8`, and `map DB 64 DUP(?)` in `.DATA?` (zeroed at load). The body does not write a cell. It zeros ECX and exits. Expected exit: **0**. Index of `(x, y)` is still `y * width + x` (lesson 16).

```asm
; Listing 04: Tile map grid in BSS (LESSON.md block 4)
; Expected exit: 0
; Expected stdout: (none)

width EQU 8
height EQU 8

.DATA?
map DB 64 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END

```

## Clamp x before it is an address

An x of 99 on a width-8 map is not a cell. Clamp **before** `map[y * width + x]`.

Listing `05-clamp-x-signed` uses a signed pair of tests. `rax = 99`. `cmp rax, 0` / `jge x_not_negative` keeps 99 (it is not negative). `cmp rax, width` / `jl x_ok` fails (99 < 8 is false), so `rax = width` then `dec rax` → 7. Expected exit: **7**.

```asm
; Listing 05: Signed clamp x to [0, width) (LESSON.md block 5)
; Expected exit: 7
; Expected stdout: (none)

width EQU 8

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 99
    cmp     rax, 0
    jge     x_not_negative
    xor     rax, rax
x_not_negative:
    cmp     rax, width
    jl      x_ok
    mov     rax, width
    dec     rax
x_ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

A negative x takes `xor rax, rax` and becomes 0. That is the signed lower bound.

Listing `06-clamp-x-unsigned` uses one unsigned compare. `cmp rax, width` / `jb ok` — 99 is not below 8, so `rax = 7` again. Expected exit: **7**.

```asm
; Listing 06: Unsigned clamp x to [0, width) (LESSON.md block 6)
; Expected exit: 7
; Expected stdout: (none)

width EQU 8

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 99
    cmp     rax, width
    jb      ok
    mov     rax, width
    dec     rax
ok:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END

```

`jb` treats RAX as unsigned. A bit-pattern of −1 is `0xFFFFFFFFFFFFFFFF`, which is **not** below 8, so the unsigned clamp would snap it to 7, not to 0. That is why listing 05 exists: signed x needs the `cmp rax, 0` / `jge` path. Do not use listing 06 on a value that can be negative.

## Parent walk: one hop

BFS / A* writes, for each tile, the tile that enqueued it. Each tick the agent takes one hop: `pos = parent[pos]`.

Listing `07-agent-parent-step` sets `agent_pos = 5`, stores 2 at `parent[5*8]`, reloads the position into RAX, reads `parent[rax*8]` into RBX, writes RBX back to `agent_pos`, and exits EBX. Expected exit: **2**.

```asm
; Listing 07: Walk parent array one step (LESSON.md block 7)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
agent_pos QWORD ?
parent DQ 8 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     agent_pos, 5
    mov     parent[5*8], 2
    mov     rax, agent_pos
    mov     rbx, parent[rax*8]
    mov     agent_pos, rbx
    mov     ecx, ebx
    call    ExitProcess
main ENDP
END

```

`5*8` and `rax*8` are byte offsets of QWORD elements. A path of length n is n such hops. When `pos == goal`, the walk is done.

## Economy: unguarded sub versus compare-then-sub

Cash is a QWORD. Criterion 4 says it never goes negative. That is a **compare**, not a hope.

Listing `08-cash-subtract` writes 10, subtracts 3 unconditionally, and exits the low dword. Expected exit: **7**. There is no `cmp`.

```asm
; Listing 08: Unconditional cash subtraction (LESSON.md block 8)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
cash QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     cash, 10
    sub     cash, 3
    mov     ecx, DWORD PTR cash
    call    ExitProcess
main ENDP
END

```

Listing `10-cash-tick-exit` is the same unguarded 10 − 3. Expected exit: **7**.

```asm
; Listing 10: Economy tick exit cash (LESSON.md block 10)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
cash QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     cash, 10
    sub     cash, 3
    mov     ecx, DWORD PTR cash
    call    ExitProcess
main ENDP
END

```

Listing `09-cash-upkeep-guard` is the guard criterion 4 asks for. It writes `cash = 10`, `upkeep = 3`, loads cash into RAX, `cmp rax, upkeep` / `jb skip`, then `sub rax, upkeep` and stores. 10 is not below 3, so the subtract runs. Expected exit: **7**.

```asm
; Listing 09: Upkeep subtract with unsigned guard (LESSON.md block 9)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
cash QWORD ?
upkeep QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     cash, 10
    mov     upkeep, 3
    mov     rax, cash
    cmp     rax, upkeep
    jb      skip
    sub     rax, upkeep
    mov     cash, rax
skip:
    mov     ecx, DWORD PTR cash
    call    ExitProcess
main ENDP
END

```

`jb` is unsigned. If cash were 2 and upkeep 3, listing 09 would skip and leave 2. Listing 08 would execute `sub` and leave `0xFFFFFFFFFFFFFFFF` (−1 as a signed QWORD). `mov ecx, DWORD PTR cash` would then pass `0xFFFFFFFF` to `ExitProcess`. An exit of 7 from listing 08 proves only that 10 − 3 = 7.

## Save and load: CreateFileA, magic, version

### Header bytes

The on-disk header is 8 bytes: four ASCII magic bytes, then a little-endian version DWORD. Listing `03-load-header-magic` stores

```
header_buf DB "PK01", 1, 0, 0, 0
```

That is bytes `50 4B 30 31 01 00 00 00`. The first DWORD, read little-endian, is **`31304B50h`** (`'P' | 'K'<<8 | '0'<<16 | '1'<<24`). The second DWORD is 1.

The listing compares that first DWORD to **`31304B50h`** and the version DWORD to 1. Both match. ECX is set to 1. Expected exit: **1**. The comment in the listing notes this is **not** the ZIP local-header signature `02014B50h` (`PK\x03\x04` is actually `04034B50h`; `PK\x01\x02` is `02014B50h`). Do not write `314B5050h`: that immediate is bytes `50 50 4B 31` (`P P K 1`).

```asm
; Listing 03: Validate save header magic/version (LESSON.md block 3)
; Expected exit: 1
; Expected stdout: (none)

.DATA
header_buf DB "PK01", 1, 0, 0, 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    ; LE DWORD for ASCII PK01: 31h,30h,4Bh,50h -> 31304B50h (not ZIP 02014B50h)
    cmp     DWORD PTR header_buf, 31304B50h
    jne     bad
    cmp     DWORD PTR header_buf[4], 1
    jne     bad
    mov     ecx, 1
    jmp     done
bad:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END

```

A loader that must accept ASCII `"PK01"` compares against `31304B50h`. Listing 12 uses that same immediate for both the harness seed and the `cmp`.

### Write park.sav

Listing `11-save-park-file` creates or truncates `park.sav` and writes the 8-byte header plus 64 map bytes.

`CreateFileA` arguments:

| Slot | Value | Meaning |
|------|------:|---------|
| RCX | `&path` | `"park.sav"` |
| EDX | `40000000h` | `GENERIC_WRITE` |
| R8D | 0 | exclusive share |
| R9D | 0 | no security attributes |
| `[rsp+32]` | 2 | `CREATE_ALWAYS` |
| `[rsp+40]` | `80h` | `FILE_ATTRIBUTE_NORMAL` |
| `[rsp+48]` | 0 | no template |

`cmp rax, -1` / `je fail` is the `INVALID_HANDLE_VALUE` test (lesson 08). The HANDLE is kept in RBX across later calls. Two `WriteFile` calls follow: header (`HLEN EQU $ - header` = 8) and `map` (64). Overlapped is NULL at `[rsp+32]`. `CloseHandle` then `ExitProcess(0)`. The fail path exits 1.

`main PROC FRAME` saves RBX (`.pushreg rbx`) and allocates 64 bytes. After the `push`, `sub rsp, 64` leaves room for shadow space plus the three stack arguments. Expected exit: **0** when the create succeeds.

```asm
; Listing 11: Save park file with Win32 I/O (LESSON.md block 11)
; Expected exit: 0
; Expected stdout: (none)

.DATA
path DB "park.sav", 0
header DB "PK01", 1, 0, 0, 0
HLEN EQU $ - header

.DATA?
map DB 64 DUP(?)
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
    lea     rdx, header
    mov     r8d, HLEN
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile

    mov     rcx, rbx
    lea     rdx, map
    mov     r8d, 64
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

`header` is again `"PK01"` plus version bytes `1,0,0,0`. That is the on-disk `"PK01"` / version 1 image — the same little-endian DWORD listing 03 and listing 12 compare (`31304B50h`).

### Read park.sav, or trust a pre-seeded header

Listing `12-load-park-file` pre-seeds `header_buf` with **`31304B50h`** and version 1, then tries `CreateFileA` with `GENERIC_READ` (`80000000h`), `FILE_SHARE_READ` (1), and `OPEN_EXISTING` (3). If the HANDLE is −1, it jumps to `validate` and uses the seed. If the open succeeds, it `ReadFile`s 8 bytes into `header_buf` and `CloseHandle`s. Validation compares the first DWORD to **`31304B50h`** and the version DWORD to 1. Match → exit **1**. Miss → exit **0**.

```asm
; Listing 12: Load park file header validation (LESSON.md block 12)
; Expected exit: 1
; Expected stdout: (none)

.DATA
path DB "park.sav", 0
header_buf DB 8 DUP(?)

.DATA?
map DB 64 DUP(?)
bytesRead DWORD ?
hFile QWORD ?

.CODE
EXTRN CreateFileA:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 64
    .allocstack 64
    .endprolog

    ; Pre-seed header for harness when file missing
    mov     DWORD PTR header_buf, 31304B50h   ; LE PK01 (P,K,0,1)
    mov     DWORD PTR header_buf[4], 1

    lea     rcx, path
    mov     edx, 80000000h
    mov     r8d, 1
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 3
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    cmp     rax, -1
    jne     have_file
    jmp     validate

have_file:
    mov     rbx, rax
    mov     rcx, rbx
    lea     rdx, header_buf
    mov     r8d, 8
    lea     r9, bytesRead
    mov     QWORD PTR [rsp+32], 0
    call    ReadFile
    mov     rcx, rbx
    call    CloseHandle

validate:
    cmp     DWORD PTR header_buf, 31304B50h
    jne     bad
    mov     eax, DWORD PTR header_buf[4]
    cmp     eax, 1
    jne     bad
    mov     ecx, 1
    call    ExitProcess

bad:
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END

```

On a harness with no `park.sav`, the open fails, the seed remains, the compares succeed, status is **1**. After listing 11 has written a real `"PK01"` file, a successful `ReadFile` overwrites the seed with the same `31304B50h` bytes, so the compare still matches (status **1**).

## Worked example: `31304B50h` is PK01 little-endian

**Task:** Listing `03-load-header-magic` comments “Expected exit: 1”. The buffer is `DB "PK01", 1, 0, 0, 0`. The compare immediate is `31304B50h`.

**What the bytes are:**

| Address | Bytes | LE DWORD |
|---------|-------|----------|
| `header_buf+0` | `50 4B 30 31` (`P K 0 1`) | `31304B50h` |
| `header_buf+4` | `01 00 00 00` | `1` |

**What the compares do:**

1. `cmp DWORD PTR header_buf, 31304B50h` — both sides `31304B50h`. Equal. Fall through.
2. `cmp DWORD PTR header_buf[4], 1` — equal. `mov ecx, 1`. Status **1**.

**Plausible wrong reading:**

*"Little-endian `"PK01"` is `314B5050h` (or the ZIP signature `02014B50h`), so I compare that immediate."*

**Why it's wrong:** `'0'` is `30h`, not an implied nibble inside `31h`. The four letters `P K 0 1` pack as **`31304B50h`**. `314B5050h` unpacks to `50 50 4B 31` (`P P K 1`). ZIP `PK\x01\x02` is `02014B50h`. Either wrong immediate takes `bad` and exits 0. The listing uses `31304B50h` and exits 1.

**The correct reading:** Store the ASCII letters, then compare the little-endian DWORD those letters form. Listing 12’s harness seed is that same `31304B50h`, so the no-file path and a successful `ReadFile` of listing 11’s file both validate.

A second wrong reading lives in the economy listings: *“Listing 08 exits 7, therefore upkeep is guarded.”* 7 is 10 − 3. The guard is the `cmp` / `jb skip` in listing 09. Delete that branch, set cash to 2, and the unguarded `sub` wraps.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| Spawn writes a SoA slot | Listing `01-visitor-spawn` increments a counter and exits **1**. |
| Listing 02 runs A* | It reserves two arrays and exits **0**. |
| `"PK01"` LE is `314B5050h` | `"PK01"` LE is **`31304B50h`**. Listing 03 compares that value and exits **1**. `314B5050h` is `P P K 1`. |
| The map listing writes a cell | Listing `04-map-grid-bss` reserves 64 bytes and exits **0**. |
| Signed and unsigned clamp agree on −1 | Signed clamp (listing 05) maps −1 to 0. Unsigned `jb` (listing 06) maps −1 to 7. Both map **99** to **7**. |
| Parent walk is a BFS loop | Listing `07-agent-parent-step` does one hop, 5 → **2**. |
| Exit 7 means the cash guard ran | Listings 08 and 10 subtract unconditionally and exit **7**. Listing 09 has the `jb skip` and also exits **7** for these inputs. |
| Version is a QWORD | The header’s second field is a **DWORD** at offset 4. |
| `CreateFileA` failure is 0 | Failure is −1. Listing 11 tests `cmp rax, -1`. |
| Listing 12 always reads `"PK01"` from disk | On a missing file it validates a pre-seeded **`31304B50h`** and exits **1**. A successful read of listing 11’s file is the same DWORD. |

## Check yourself

1. Listing `05-clamp-x-signed` and listing `06-clamp-x-unsigned` both start at 99 and exit 7. What does each do with `rax = -1`, and which one is safe as a map index for that input?
2. Listing `09-cash-upkeep-guard` uses `cmp rax, upkeep` / `jb skip` before `sub`. What remains in `cash` if you start at 2 with upkeep 3? What would listing `08-cash-subtract` leave for the same inputs?
3. Write the four bytes of `"PK01"` and the little-endian DWORD they form. What immediate does listing `03-load-header-magic` compare, and what status does that produce?
4. Listing `07-agent-parent-step` stores 2 at `parent[5*8]`. Why `*8`, and what is in `agent_pos` after the load/`mov` pair?
5. Listing `11-save-park-file` passes `40000000h` in EDX and `2` at `[rsp+32]`. Name those two `CreateFileA` parameters. What does listing `12-load-park-file` pass instead for access and disposition?

## Key takeaways

- Spawn is a counter increment (listing `01-visitor-spawn`, exit **1**). Listing `02-pathfind-step` is an open/closed reserve that exits **0**.
- Clamp x **before** indexing. Signed (listing 05) and unsigned (listing 06) both map 99 to **7** on width 8; they disagree on negatives.
- One hop is `pos = parent[pos]`. Listing `07-agent-parent-step` walks 5 → **2**.
- Unguarded `sub` (listings 08 and 10) exits **7** for 10 − 3 and wraps if cash < upkeep. Listing `09-cash-upkeep-guard` compares unsigned, then subtracts, and exits **7** for the same 10 and 3.
- `"PK01"` as a little-endian DWORD is **`31304B50h`**. Listing `03-load-header-magic` compares that value and exits **1**.
- Save is `CreateFileA` (`GENERIC_WRITE`, `CREATE_ALWAYS`) + two `WriteFile`s + `CloseHandle` (listing 11, exit **0** on success). Load pre-seeds or `ReadFile`s 8 bytes and exits **1** when magic and version match the immediate it uses (listing 12).
- Track connect is `(facing + 2) AND 3` (listing `13-track-piece-connect`, exit **1**). The 100-tick loop exits **100** (listing 14). Listing `15-render-map-p6` writes an 11-byte P6 header plus 12 RGB bytes and exits **23** on success.

## Lookup

- File API: [CreateFileA](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea), [WriteFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile), [ReadFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-readfile), [CloseHandle](https://learn.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-closehandle)
- Access and disposition: `GENERIC_READ` = `80000000h`, `GENERIC_WRITE` = `40000000h`, `CREATE_ALWAYS` = 2, `OPEN_EXISTING` = 3, `FILE_ATTRIBUTE_NORMAL` = `80h`
- Microsoft x64 calling convention: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- Multi-file builds: lesson 09. File I/O detail: lesson 08. BFS / SoA: lesson 17. P6 PPM: lesson 14.

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

The Jack listings above are the teaching programs. The drill names under `exercises/` (map cell, track connect, cash upkeep, save header, and the rest) are separate student stubs. The capstone binary is the multi-file program that satisfies the six criteria, not any one drill.
