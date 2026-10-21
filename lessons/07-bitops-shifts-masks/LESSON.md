# Lesson 07 — Bit Operations, Shifts, and Masks

Registers hold integers. This lesson treats those integers as packed bit vectors: you keep, set, toggle, and invert bits with `and`, `or`, `xor`, and `not`; you slide fields with `shl`, `shr`, and `sar`; you wrap bits instead of dropping them with `rol` and `ror`. You pack several narrow values into one register and unpack them again. You count set bits, trailing zeros, and leading zeros with ordinary loops. The distinction that bites people is `shr` (zeros enter at the top) versus `sar` (the sign bit is copied downward).

Every listing is a complete MASM program: `.CODE`, `EXTRN ExitProcess:PROC`, `main PROC` / `main ENDP`, and `END`. The first argument to `ExitProcess` is the process status in RCX. Assemble and link from an x64 Native Tools prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

## What this lesson asks of you

You must be able to mask with `and`, set bits with `or`, toggle with `xor`, and invert every bit with `not` (which does not update flags). You multiply and divide by powers of two with `shl` and `shr` when the value is unsigned; you use `sar` when it is signed so the sign survives. You pack by masking each field to its width, shifting it to its position, and OR-ing the pieces. You unpack by shifting the field down to bit 0, then masking. Shift counts are an immediate or `cl` — not another general-purpose register. You implement popcount, trailing-zero, and leading-zero loops that test bit 0 or the top bit and shift. You extract 8-bit RGB fields from a packed color and you see why a shift without a following mask leaves leftover high bits in the register.

## A survey of the operators

Listing `01-bit-operations` runs one example of `and`, `or`, `xor`, `not`, `shl`, and `shr`, then exits with the OR result. `sub rsp, 32` is the Microsoft x64 shadow space before `call ExitProcess`. The OR path loads `0x08` into RBX and ORs `0x04`, so RBX is 12. `mov rcx, rbx` makes that 12 the `ExitProcess` status. Expected exit: **12**.

The other demos in this listing are not the exit code. `and` leaves 15 in RAX. `xor rcx, 0xFF` after `mov rcx, 0xFF` leaves RCX = 0, then `mov rcx, rbx` overwrites it. `not rdx` on 0 leaves RDX = −1. `shl r8, 2` on 3 leaves R8 = 12. `shr r9, 2` on 48 leaves R9 = 12.

```asm
; Listing 01: Bitwise operations
;
; Purpose: Demonstrate AND, OR, XOR, NOT, SHL, SHR.
; Expected exit code: 12
; Expected output: (none)
;
; Build: ml64 /c /Fo01-bit-operations.obj 01-bit-operations.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-bit-operations.exe 01-bit-operations.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; AND: clear bits
    mov rax, 0xFF              ; 11111111
    and rax, 0x0F              ; 00001111 -> RAX = 15
    
    ; OR: set bits
    mov rbx, 0x08              ; 00001000
    or rbx, 0x04               ; 00000100 -> RBX = 12
    
    ; XOR: toggle bits
    mov rcx, 0xFF
    xor rcx, 0xFF              ; RCX = 0
    
    ; NOT: invert all bits
    mov rdx, 0
    not rdx                    ; RDX = -1 (all 1s)
    
    ; SHL: shift left (multiply by 2)
    mov r8, 3
    shl r8, 2                  ; R8 = 12 (3 * 4)
    
    ; SHR: shift right (unsigned divide by 2)
    mov r9, 48
    shr r9, 2                  ; R9 = 12 (48 / 4)
    
    mov rcx, rbx               ; Exit with 12
    call ExitProcess
main ENDP

END
```

## Logical operations: `and`, `or`, `xor`, `not`

### `and`: masking (keeping specific bits)

`and dest, src` keeps only the bits that are 1 in both operands and writes that result to `dest`. Use it to extract a field or to clear bits you do not want.

Listing `02-and-masking` loads `0FFh` (eight 1 bits) into RAX and ANDs `0Fh`. The high nibble goes to 0; the low nibble stays `0Fh`. RAX is 15. `mov rcx, rax` then `call ExitProcess` makes the status 15. Expected exit: **15**.

This listing uses MASM hex (`0FFh`, `0Fh`). A literal that starts with A–F needs a leading 0 so the assembler sees a number, not an identifier: write `0FFh`, not `FFh`.

```asm
; Listing 02: AND masking (lines 12-18 of LESSON.md)
;
; Purpose: Extract low nibble using AND mask.
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo02-and-masking.obj 02-and-masking.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-and-masking.exe 02-and-masking.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 0FFh              ; RAX = 11111111 binary
    and rax, 0Fh               ; RAX = 00001111 binary (keep low nibble)
                               ; Result: RAX = 15
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

To clear bit *n*, AND with a mask that has a 0 at position *n* and 1s everywhere else. MASM's assemble-time complement is the `NOT` operator, so `and rax, NOT 8` assembles a 64-bit mask with bit 3 clear. That operator is not the `not` instruction; the instruction inverts a register at run time and is listing `10-not-instruction`.

`test dest, src` computes the same AND and updates flags, but it does not write the result. Use `test` when you only need ZF/SF/PF.

### `or`: setting bits

`or dest, src` turns on every bit that is 1 in `src` and leaves the other bits of `dest` unchanged.

Listing `03-or-setting-bits` zeros RAX with `xor rax, rax`, ORs 1 (bit 0), then ORs 4 (bit 2). RAX is 5 (`101` binary). Expected exit: **5**.

```asm
; Listing 03: OR setting bits (lines 24-32 of LESSON.md)
;
; Purpose: Set bits using OR.
; Expected exit code: 5
; Expected output: (none)
;
; Build: ml64 /c /Fo03-or-setting-bits.obj 03-or-setting-bits.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-or-setting-bits.exe 03-or-setting-bits.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rax, rax               ; RAX = 0
    or rax, 1                  ; Set bit 0
    or rax, 4                  ; Set bit 2
                               ; Result: RAX = 5 (binary 101)
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

To set bit *n*, OR with `1` shifted left *n* positions. The listing uses the constants 1 and 4 directly.

### `xor`: toggling, zeroing, and a fragile swap

`xor dest, src` flips every bit that is 1 in `src`. A 0 bit in `src` leaves the corresponding bit of `dest` alone.

Listing `04-xor-toggle` loads 5 (`101` binary) and XORs 1. Bit 0 flips; RAX becomes 4. Expected exit: **4**.

```asm
; Listing 04: XOR toggling (lines 36-47 of LESSON.md)
;
; Purpose: Toggle bits using XOR.
; Expected exit code: 4
; Expected output: (none)
;
; Build: ml64 /c /Fo04-xor-toggle.obj 04-xor-toggle.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-xor-toggle.exe 04-xor-toggle.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 5                 ; Binary 101
    xor rax, 1                 ; Flip bit 0 → binary 100
                               ; Result: RAX = 4
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`xor reg, reg` is the usual way to zero a register: every bit XORed with itself is 0, the encoding is short, and a 32-bit form zero-extends into the 64-bit register. Listing `03-or-setting-bits` already used `xor rax, rax` for that.

XOR can also swap two distinct registers without a temporary. Listing `09-xor-swap` starts with RCX = 5 and RDX = 42, then:

1. `xor rcx, rdx` → RCX = 5 XOR 42 = 47
2. `xor rdx, rcx` → RDX = 42 XOR 47 = 5
3. `xor rcx, rdx` → RCX = 47 XOR 5 = 42

`call ExitProcess` then uses RCX = 42 as the status. Expected exit: **42**. This listing does not allocate shadow space.

```asm
; 09-xor-swap.asm
;
; Purpose: Demonstrate XOR-based register swap without a temporary
; Expected exit code: 42
; Expected stdout: (none)
;
; Swaps two registers using three XOR operations.
; Note: This technique requires distinct registers and is fragile
; (a signal mid-swap can tear values). Prefer XCHG for real swaps.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rcx, 5          ; a = 5
    mov     rdx, 42         ; b = 42
    
    ; XOR swap algorithm:
    xor     rcx, rdx        ; a ^= b  → a = 5^42 = 47
    xor     rdx, rcx        ; b ^= a  → b = 42^47 = 5
    xor     rcx, rdx        ; a ^= b  → a = 47^5 = 42
    
    ; Now: rcx=42, rdx=5 (swapped)
    
    call    ExitProcess     ; Exit with 42
main ENDP

END
```

The three-XOR sequence requires two different registers. XOR a register with itself and you get zero, not a swap. A signal or an exception in the middle of the sequence can tear one of the values. Prefer `xchg` when you actually need a swap.

### `not`: flipping every bit

`not dest` inverts each bit (0→1, 1→0). Unlike `and` / `or` / `xor`, `not` does **not** update flags.

Listing `10-not-instruction` writes `0Fh` to AL (`00001111`), then `not al` produces `11110000` (`0F0h` = 240). `movzx ecx, al` zero-extends that byte into ECX for `ExitProcess`. Expected exit: **240**. This listing does not allocate shadow space.

```asm
; 10-not-instruction.asm
;
; Purpose: Demonstrate NOT instruction (bitwise inversion)
; Expected exit code: 240
; Expected stdout: (none)
;
; NOT inverts all bits: 0→1, 1→0
; Unlike other logical ops, NOT does NOT update flags

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 0Fh         ; al = 00001111 binary
    not     al              ; al = 11110000 binary = 0xF0 = 240
    
    movzx   ecx, al         ; Zero-extend to 32-bit for ExitProcess
    call    ExitProcess     ; Exit with 240
main ENDP

END
```

## Shifts: `shl`, `shr`, `sar`

A shift moves bits left or right. The bit that leaves one end goes into CF. New bits enter from the other end. The shift count is an immediate or the value in `cl` (the low 8 bits of RCX). `shl rax, rbx` does not assemble; move the count into `cl` first.

| Instruction | Direction | Bit entering | What it does | Typical use |
|-------------|-----------|--------------|--------------|-------------|
| `shl dest, n` | Left | 0 at bit 0 | Multiply by 2^n | Unsigned multiply, position a field |
| `shr dest, n` | Right | 0 at the top | Divide by 2^n (unsigned) | Unsigned divide, extract high bits |
| `sar dest, n` | Right | Copy of the sign bit | Divide by 2^n (signed) | Signed divide |

### `shl`: shift left (multiply)

Listing `05-shl-multiply` loads 3 and shifts left by 2. That is 3 × 4 = 12. Expected exit: **12**.

```asm
; Listing 05: SHL multiply (lines 84-89 of LESSON.md)
;
; Purpose: Multiply by power of 2 using SHL.
; Expected exit code: 12
; Expected output: (none)
;
; Build: ml64 /c /Fo05-shl-multiply.obj 05-shl-multiply.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-shl-multiply.exe 05-shl-multiply.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 3
    shl rax, 2                 ; RAX = 3 * 4 = 12
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Bits shifted out of the top go into CF (the last one shifted out remains there). Unsigned values, and signed values that do not leave their range, read this as multiply by 2^n.

### `shr`: shift right logical (unsigned divide)

Listing `06-shr-divide` loads 12 and shifts right by 2. That is 12 / 4 = 3, remainder discarded. Vacated high bits become 0. Expected exit: **3**.

```asm
; Listing 06: SHR unsigned divide (lines 93-99 of LESSON.md)
;
; Purpose: Unsigned division by power of 2 using SHR.
; Expected exit code: 3
; Expected output: (none)
;
; Build: ml64 /c /Fo06-shr-divide.obj 06-shr-divide.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-shr-divide.exe 06-shr-divide.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 12
    shr rax, 2                 ; RAX = 12 / 4 = 3
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`shr` is correct for unsigned values. It is wrong for a negative signed value: the sign bit becomes 0, so the result is a large positive number.

### `sar`: shift right arithmetic (signed divide)

Listing `07-sar-signed-divide` loads −8 and arithmetic-shifts right by 1. The sign bit is copied into the vacated high bits, so RAX becomes −4. `mov rcx, rax` then `and rcx, 0FFh` keeps the low 8 bits for `ExitProcess`. −4 as an unsigned byte is 252 (`0FCh`). Expected exit: **252**.

```asm
; Listing 07: SAR signed divide (lines 101-110 of LESSON.md)
;
; Purpose: Signed division preserving sign with SAR.
; Expected exit code: 252 (-4 as unsigned byte)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-sar-signed-divide.obj 07-sar-signed-divide.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-sar-signed-divide.exe 07-sar-signed-divide.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, -8
    sar rax, 1                 ; RAX = -8 / 2 = -4 (correct signed)
    
    mov rcx, rax
    and rcx, 0FFh              ; Truncate to byte for exit code
    call ExitProcess
main ENDP

END
```

If this listing used `shr rax, 1` instead of `sar`, −8 (`0FFFFFFFFFFFFFFF8h`) would become `07FFFFFFFFFFFFFFCh` — a large positive value — and the low byte of that is `0FCh` as well, which would hide the bug if you only looked at the exit status. Read RAX before the mask when you are checking signed behavior.

`sar` rounds toward −∞ (the same direction as a signed divide that truncates toward −∞, not toward zero). For −8 / 2 the two agree (−4). They disagree on odd negatives (for example −5 `sar` 1 is −3, not −2).

### Flag effects

After `shl`, `shr`, or `sar`, the last bit shifted out is in CF. SF, ZF, and PF reflect the result. OF is defined only for a 1-bit shift; for a multi-bit shift OF is undefined. AF is undefined.

## Packing and unpacking bitfields

A **bitfield** is a narrow value stored at a known position inside a wider register. To pack several fields:

1. Mask each value to its width so it cannot spill into the next field.
2. Shift it left to its position.
3. OR the pieces together.

Listing `08-pack-bitfields` packs three 3-bit values: a = 5 in bits 0–2, b = 2 in bits 3–5, c = 1 in bits 6–8. The width mask is `7h` (2^3 − 1). After the three ORs, RAX is `001_010_101` binary = 85. Expected exit: **85**.

```asm
; Listing 08: Pack bitfields (lines 124-141 of LESSON.md)
;
; Purpose: Pack three 3-bit values into one register.
; Expected exit code: 85 (0b001_010_101)
; Expected output: (none)
;
; Build: ml64 /c /Fo08-pack-bitfields.obj 08-pack-bitfields.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-pack-bitfields.exe 08-pack-bitfields.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Pack a=5, b=2, c=1 into bits 0-2, 3-5, 6-8
    mov rax, 5
    and rax, 7h                ; Mask to 3 bits
    
    mov rbx, 2
    and rbx, 7h                ; Mask to 3 bits
    shl rbx, 3                 ; Shift to bits 3-5
    or rax, rbx
    
    mov rbx, 1
    and rbx, 7h                ; Mask to 3 bits
    shl rbx, 6                 ; Shift to bits 6-8
    or rax, rbx
    
    ; Result: RAX = 0b001_010_101 = 85
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

To unpack a field at bit position *pos* with width *w*: shift right by *pos*, then AND with (2^w − 1).

Listing `11-unpack-bitfield` starts from the packed value `055h` (the 85 produced above), shifts right by 3 so bits 3–5 land in bits 0–2, and ANDs 7. RAX is 2 — the middle field. `mov ecx, eax` then exits. Expected exit: **2**. This listing does not allocate shadow space.

```asm
; 11-unpack-bitfield.asm
;
; Purpose: Extract a bitfield by shifting and masking
; Expected exit code: 2
; Expected stdout: (none)
;
; Extracts field 'b' (bits 3-5, width 3) from packed value 0x55.
; To unpack: shift field to bit 0, then mask to width.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 055h       ; Packed value = 0b001_010_101 = 0x55
    
    ; Extract 'b' (bits 3-5, width 3):
    shr     rax, 3          ; Shift bits 3-5 down to bits 0-2
    and     rax, 7          ; Mask to 3 bits (2^3 - 1 = 7)
    
    ; Result: rax = 2 (the middle 3-bit field)
    
    mov     ecx, eax
    call    ExitProcess     ; Exit with 2
main ENDP

END
```

Mask **before** you shift when packing (so a too-wide value cannot overwrite a neighbor). Shift **then** mask when unpacking (so leftover high bits do not stay in the register). The worked example at the end of this lesson is the unpack rule failing on purpose.

## Rotate: `rol` and `ror`

A shift discards the bit that leaves one end. A **rotate** feeds that bit back into the other end. `rol dest, n` rotates left; `ror dest, n` rotates right. CF gets the bit that wrapped. OF is defined only for a 1-bit rotate.

Listing `12-rol-rotate` loads `80h` into AL (`10000000`) and rotates left by 1. The only 1-bit moves from position 7 to position 0. AL is 1. `movzx ecx, al` then exits. Expected exit: **1**. This listing does not allocate shadow space.

```asm
; 12-rol-rotate.asm
;
; Purpose: Demonstrate ROL (rotate left) instruction
; Expected exit code: 1
; Expected stdout: (none)
;
; ROL shifts bits left, wrapping the MSB around to the LSB.
; Unlike SHL, no bit is lost.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 80h         ; al = 10000000 binary
    rol     al, 1           ; Rotate left by 1
    
    ; Bit 7 (the only set bit) moves to bit 0
    ; Result: al = 00000001 binary = 1
    
    movzx   ecx, al
    call    ExitProcess     ; Exit with 1
main ENDP

END
```

Use a rotate when every bit must survive (circular buffers, some checksums, bit-reversal building blocks). There is no `ror` listing on this branch; the instruction is the opposite direction of the `rol` you just read.

<!-- LISTING-PENDING: no Jack listing for ror; 12-rol-rotate.asm demonstrates ROL only -->

## Bit-counting loops

x86-64 has `popcnt`, `lzcnt`, and `tzcnt`. Implementing the same work as a loop is how you see the test-and-shift pattern. These three listings use `main PROC FRAME`, `push rbx`, `.pushreg rbx`, and `.endprolog` so the unwinder knows RBX was saved. The value under test lives in RBX, not in an argument register: `main` is the process entry, not a callee with a value in RCX.

### Popcount (count set bits)

Listing `13-popcount-loop` counts 1-bits in 11 (`1011` binary). The loop tests RBX for zero, tests bit 0, increments RAX when that bit is set, then `shr rbx, 1`. For 11 the body runs four times (values 11, 5, 2, 1); the fifth `test rbx, rbx` hits zero and jumps to `done`. RAX is 3. Expected exit: **3**.

```asm
; 13-popcount-loop.asm
;
; Purpose: Count set bits (popcount) using a loop
; Expected exit code: 3
; Expected stdout: (none)
;
; Implements popcount by shifting right and counting each set bit 0.
; For value 0b1011 (decimal 11), there are 3 set bits.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     rbx, 11         ; Value = 0b1011 (3 set bits)
    xor     rax, rax        ; counter = 0
    
popcount_loop:
    test    rbx, rbx
    jz      done
    
    test    rbx, 1          ; Is bit 0 set?
    jz      skip_inc
    inc     rax             ; Yes, count it
    
skip_inc:
    shr     rbx, 1          ; Shift right
    jmp     popcount_loop
    
done:
    ; rax = count of 1 bits = 3
    mov     ecx, eax
    call    ExitProcess     ; Exit with 3
main ENDP

END
```

### Count trailing zeros (ctz)

Listing `14-count-trailing-zeros` counts low-order zeros in 88 (`1011000` binary). It does not test the whole register for zero first; it tests bit 0, increments while that bit is 0, and shifts. Three zeros sit below the first 1, so RAX is 3. Expected exit: **3**. The listing assumes a nonzero input; a zero value would shift forever.

```asm
; 14-count-trailing-zeros.asm
;
; Purpose: Count trailing zeros (ctz) using a loop
; Expected exit code: 3
; Expected stdout: (none)
;
; Shifts right until bit 0 is set, counting shifts.
; For 0b1011000 (decimal 88), there are 3 trailing zeros.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     rbx, 88         ; Value = 0b1011000 (3 trailing zeros)
    xor     rax, rax        ; counter = 0
    
ctz_loop:
    test    rbx, 1          ; Is bit 0 set?
    jnz     done
    
    inc     rax             ; Count this zero
    shr     rbx, 1          ; Shift right
    jmp     ctz_loop
    
done:
    ; rax = number of trailing zeros = 3
    mov     ecx, eax
    call    ExitProcess     ; Exit with 3
main ENDP

END
```

### Count leading zeros (clz)

Listing `15-count-leading-zeros` counts high-order zeros in a 16-bit value. It loads `0F0h` into AX (`0000000011110000`), keeps the counter in RBX, and loops while RBX < 16 and bit 15 of AX is clear, shifting AX left each time. Eight zeros sit above the first 1, so RBX is 8. `mov ecx, ebx` then exits. Expected exit: **8**.

```asm
; 15-count-leading-zeros.asm
;
; Purpose: Count leading zeros (clz) in a 16-bit value
; Expected exit code: 8
; Expected stdout: (none)
;
; Shifts left until bit 15 is set, counting shifts.
; For 0x00F0 (binary 0000000011110000), there are 8 leading zeros.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     ax, 0F0h        ; Value = 0x00F0 (8 leading zeros)
    xor     rbx, rbx        ; counter = 0
    
clz_loop:
    cmp     rbx, 16         ; Processed all 16 bits?
    jge     done
    
    test    ax, 8000h       ; Is bit 15 set?
    jnz     done
    
    inc     rbx             ; Count this leading zero
    shl     ax, 1           ; Shift left
    jmp     clz_loop
    
done:
    ; rbx = count of leading zeros = 8
    mov     ecx, ebx
    call    ExitProcess     ; Exit with 8
main ENDP

END
```

`test ax, 8000h` is the 16-bit top-bit check. A 64-bit clz would test the sign bit of RAX (`test rax, rax` then look at SF, or `test rax, 8000000000000000h`) and shift 64 times at most.

## Worked example: extracting RGB from a 24-bit color

A 24-bit RGB color packs red in bits 16–23, green in bits 8–15, and blue in bits 0–7. Listing `16-rgb-extraction` loads `0ABCDEFh` and extracts each 8-bit field.

The prologue is unwind-aware: `main PROC FRAME`, then `push rbx` / `push r12` / `push r13` with a `.pushreg` for each and `.endprolog`. Those three registers are nonvolatile on Windows; this `main` never returns, but the listing still records the saves.

| Field | Bits | Instructions | Register | Value |
|-------|------|--------------|----------|------:|
| Red | 16–23 | `shr` 16, `and` `0FFh` | RBX | `0ABh` = 171 |
| Green | 8–15 | `shr` 8, `and` `0FFh` | R12 | `0CDh` = 205 |
| Blue | 0–7 | `and` `0FFh` (already at bit 0) | R13 | `0EFh` = 239 |

`mov ecx, r13d` then `call ExitProcess` exits with the blue component. Expected exit: **239**.

```asm
; 16-rgb-extraction.asm
;
; Purpose: Extract RGB components from a 24-bit color value
; Expected exit code: 239
; Expected stdout: (none)
;
; A 24-bit RGB color packs three 8-bit components:
;   Red:   bits 16-23
;   Green: bits 8-15
;   Blue:  bits 0-7
;
; Extracts each component from 0xABCDEF and exits with blue component.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    r12
    .pushreg r12
    push    r13
    .pushreg r13
    .endprolog
    
    mov     rax, 0ABCDEFh   ; color = 0xABCDEF
    
    ; Extract red (bits 16-23)
    mov     rbx, rax
    shr     rbx, 16         ; Shift bits 16-23 down to bits 0-7
    and     rbx, 0FFh       ; Mask to 8 bits
    ; rbx = 0xAB = 171
    
    ; Extract green (bits 8-15)
    mov     r12, rax
    shr     r12, 8
    and     r12, 0FFh
    ; r12 = 0xCD = 205
    
    ; Extract blue (bits 0-7)
    mov     r13, rax
    and     r13, 0FFh       ; No shift needed (already at bit 0)
    ; r13 = 0xEF = 239
    
    ; Exit with blue component
    mov     ecx, r13d
    call    ExitProcess     ; Exit with 239
main ENDP

END
```

Build and run from an x64 Native Tools prompt:

```bat
ml64 /c 16-rgb-extraction.asm
link /OUT:16-rgb-extraction.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-rgb-extraction.obj kernel32.lib
16-rgb-extraction.exe
echo %ERRORLEVEL%
```

`ERRORLEVEL` is 239.

### A plausible wrong reading (and why it fails)

A common mistake is to shift a field down and skip the mask. That looks fine when the bits above the field are already zero. Listing `17-rgb-extract-no-mask` loads `0FFABCDEFh` — the same `ABCDEF` payload with `0FFh` sitting above bit 23 — then shifts RBX right by 16 and never ANDs `0FFh`.

After the shift, RBX holds `0FFABh`, not `0ABh`. `mov ecx, ebx` passes that polluted “red” to `ExitProcess`. The full status is `0FFABh` = 65451. The course harness, and the low 8 bits of the process status, are 171 (`0ABh`). Expected harness exit: **171**.

```asm
; Listing 17: RGB extract without mask (wrong reading from LESSON.md)
;
; Purpose: Shows why you must mask after shifting when high bits are set.
; Expected exit: 171 (harness uses low 8 bits; ExitProcess code is 65451 / 0xFFAB)
; Expected stdout: (none)
;
; Build: ml64 /c /Fo17-rgb-extract-no-mask.obj 17-rgb-extract-no-mask.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:17-rgb-extract-no-mask.exe 17-rgb-extract-no-mask.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 32
    .allocstack 32
    .endprolog

    mov rax, 0FFABCDEFh        ; Bits above bit 23 pollute a bare shr

    mov rbx, rax
    shr rbx, 16                ; Red field shifted down — MISSING and rbx, 0FFh

    mov ecx, ebx               ; Exit with polluted "red" low bits
    call ExitProcess
main ENDP

END
```

The mask `and rbx, 0FFh` after the shift is what makes a field extract independent of whatever lived in the high bits. Listing `16-rgb-extraction` does that for red and green. Listing `17-rgb-extract-no-mask` is the same red extract with the mask deleted so you can see `0FFABh` survive.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| `shr` vs `sar` | `shr` fills with zeros (unsigned). `sar` copies the sign bit (signed). `shr` on a negative value produces a large positive number. Listing `07-sar-signed-divide` uses `sar` on −8 and exits 252. |
| `shl` overflow (unsigned vs signed) | For unsigned values CF reports a 1-bit that left the top. For signed values OF (1-bit shifts only) reports that the sign changed. Do not read OF after `shl dest, 2`. |
| Shift count in `cl` vs other registers | Only an immediate or `cl` is a legal count. `shl rax, rbx` does not assemble; `mov cl, bl` then `shl rax, cl` does. |
| `and` vs `test` | `and` writes `a AND b` to the destination. `test` computes the same AND, updates flags, and discards the result. |
| `xor reg, reg` vs `mov reg, 0` | Both zero the register. `xor` is the short, idiomatic form. Listing `03-or-setting-bits` starts that way. |
| XOR-swap vs `xchg` | Three XORs swap two distinct registers (listing `09-xor-swap`, exit 42). XOR a register with itself and you get 0. Prefer `xchg` for a real swap. |
| Rotate vs shift | `rol` / `ror` wrap bits; `shl` / `shr` / `sar` discard them. Listing `12-rol-rotate` turns `80h` into 1; `shl al, 1` on the same byte would produce 0 and set CF. |
| Mask before vs after a shift | Pack: mask, then shift, then OR (listing `08-pack-bitfields`). Unpack: shift, then mask (listing `11-unpack-bitfield`). Skip the unpack mask and high bits remain (listing `17-rgb-extract-no-mask`). |
| `not` vs assemble-time `NOT` | The `not` instruction inverts a register at run time and does not touch flags (listing `10-not-instruction`, exit 240). `NOT` in an operand (`and rax, NOT 8`) is computed by the assembler. |
| Argument registers | These listings are process entry points. Values live in RAX/RBX/RCX/RDX/R8/R9/R12/R13 as each listing writes them. Win32 arguments, when you call `ExitProcess`, go in RCX — not RDI. |

## Check yourself

1. You want to set bit 5 of RAX without changing the other bits. Which instruction and operand do you use?
2. You want to divide the signed value −16 by 4 with a shift. Which shift instruction do you use, and why not the other right shift?
3. Extract bits 4–7 (a 4-bit field at position 4) from RAX = `0ABCDh`. Write the shift and the mask.
4. After `shl rax, 3`, which flag tells you whether any bit left the top? Is OF defined for that instruction?
5. Trace listing `13-popcount-loop` on 11 (`1011` binary): how many times does the loop body run, and what is RAX at `done`?

## Key takeaways

- `and` keeps bits, `or` sets them, `xor` toggles them, `not` inverts all of them and does not update flags.
- `shl` multiplies by 2^n; `shr` divides unsigned and fills with zeros; `sar` divides signed and copies the sign bit. Listing `07-sar-signed-divide` exits 252 because −4 truncated to a byte is `0FCh`.
- Pack by masking to width, shifting to position, and OR-ing. Unpack by shifting to bit 0, then masking. A missing unpack mask leaves leftover high bits: listing `17-rgb-extract-no-mask` shifts `0FFABCDEFh` and leaves `0FFABh` (harness low 8 bits = 171).
- `rol` / `ror` wrap; shifts discard. Shift counts are an immediate or `cl`.
- `xor reg, reg` is the zero idiom. XOR-swap needs two distinct registers and is fragile; prefer `xchg`.
- RGB in `0ABCDEFh` is red 171, green 205, blue 239. Listing `16-rgb-extraction` exits 239.

## Lookup

- **Logical instructions:** Intel® 64 and IA-32 Architectures Software Developer's Manual, Volume 2, entries for `AND`, `OR`, `XOR`, `NOT`, `TEST`
- **Shift and rotate:** Volume 2, entries for `SAL`/`SHL`, `SHR`, `SAR`, `ROL`, `ROR`
- **Flag effects:** Volume 1, §3.4 (RFLAGS), CF / OF / SF / ZF after shifts
- **Microsoft x64 calling convention:** first integer argument in RCX, 32-byte shadow space, return in RAX — [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- **ExitProcess:** [ExitProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess)

## Exercises

24 drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

Logic: `01-and-mask.asm`, `02-or-flags.asm`, `03-xor-swap.asm`, `09-xor-checksum.asm`, `10-bit-set-clear.asm`, `11-isolate-lowbit.asm`, `12-next-power-of-two-bit.asm`. Shifts: `04-shl-mul.asm`, `05-sar-sign.asm`, `14-sar-vs-shr.asm`, `18-mask-range.asm`, `19-debug-sign-shift.asm`, `21-gray-code.asm`, `22-stretch-swar-avg.asm`. Fields: `07-extract-bitfield.asm`, `13-shl-shl-combine.asm`, `15-bitfield-pack.asm`, `16-bitfield-unpack.asm`. Rotate and counts: `08-from-scratch-rol.asm`, `17-rotate-parity.asm`, `06-popcount-naive.asm`, `20-count-leading-zeros-loop.asm`, `23-stretch-bit-reverse8.asm`, `24-from-scratch-ntz.asm`.
