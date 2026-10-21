# Lesson 02 — Arithmetic & Flags

Arithmetic instructions do more than compute results — they also record facts about those results in the FLAGS register. This lesson teaches you to read those flags and use them for decisions. You will perform addition, subtraction, multiplication, and division correctly for both signed and unsigned integers, understand why `cmp` and `test` exist (they discard the result but keep the flags), and use the `setcc` family to turn flag states into 0 or 1. Using the wrong division instruction or the wrong flag produces silently incorrect results.

## What this lesson asks of you

Use `add`, `sub`, `inc`, `dec`, and `neg`. Read ZF, SF, CF, and OF. Set up `rdx:rax` with `cqo` before `idiv` or `xor rdx, rdx` before `div`. Distinguish `imul` from `mul`. Use `cmp` and `test`, then `setcc` to materialize booleans.

These instructions are the same on Windows and Linux. What changes is the wrapper: `main PROC`, shadow space, `call ExitProcess`.

## Integer arithmetic

Destination is both source and result:

```asm
; Listing 01: Basic arithmetic operations
;
; Purpose: Demonstrates ADD, SUB, INC, DEC, NEG.
; Expected exit code: 15
; Expected output: (none)
;
; Build: ml64 /c /Fo01-basic-arithmetic.obj 01-basic-arithmetic.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-basic-arithmetic.exe 01-basic-arithmetic.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 10
    add rax, 5                 ; RAX = 15
    sub rax, 3                 ; RAX = 12
    inc rax                    ; RAX = 13
    inc rax                    ; RAX = 14
    dec rax                    ; RAX = 13
    add rax, 2                 ; RAX = 15
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Trace: 10+5=15, −3=12, inc=13, inc=14, dec=13, +2=15. Exit 15.

`inc`/`dec` update ZF, SF, OF, but **not** CF (8086 encoding choice). If you need CF after +1, use `add reg, 1`.

`neg rax` is two's complement: `rax = −rax`.

## Multiplication: signed vs unsigned

### Signed: `imul`

```asm
; Listing 02: Signed multiplication with IMUL
;
; Purpose: Demonstrates IMUL in various forms.
; Expected exit code: 20
; Expected output: (none)
;
; Build: ml64 /c /Fo02-signed-multiply.obj 02-signed-multiply.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-signed-multiply.exe 02-signed-multiply.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Two-operand form
    mov rax, 5
    imul rax, 4                ; RAX = 5 * 4 = 20
    
    ; Three-operand immediate form
    mov rbx, 3
    imul rcx, rbx, 7           ; RCX = RBX * 7 = 21
    
    ; Exit with first result (20)
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Two- and three-operand `imul` truncate to the destination size. One-operand `imul rbx` writes the full product to `rdx:rax`. The listing exits with 20, discarding the 21 in RCX (which `ExitProcess` would also clobber as argument 1).

### Unsigned: `mul`

```asm
; Listing 03: Unsigned multiplication with MUL
;
; Purpose: Demonstrates MUL producing rdx:rax result.
; Expected exit code: 40
; Expected output: (none)
;
; Build: ml64 /c /Fo03-unsigned-multiply.obj 03-unsigned-multiply.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-unsigned-multiply.exe 03-unsigned-multiply.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 10
    mov rbx, 4
    mul rbx                    ; RDX:RAX = RAX * RBX = 40
                               ; RAX = 40, RDX = 0 (high bits)
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`mul` has only the one-operand form. RDX is 0 here because 40 fits in 64 bits. Multiplying −1 by 2 with `imul` yields −2; with `mul` it treats −1 as `0xFFFFFFFFFFFFFFFF` and produces a huge unsigned product.

## Division: `rdx:rax` as the dividend

64-bit divide takes a 128-bit dividend in `rdx:rax`. Quotient in RAX, remainder in RDX.

### Signed: `cqo` then `idiv`

```asm
; Listing 04: Signed division with CQO and IDIV
;
; Purpose: Demonstrates proper setup for signed division.
; Expected exit code: 7 (quotient of 22/3)
; Expected output: (none)
;
; Build: ml64 /c /Fo04-signed-division.obj 04-signed-division.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-signed-division.exe 04-signed-division.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 22                ; Dividend in RAX
    cqo                        ; Sign-extend RAX into RDX:RAX
    mov rbx, 3                 ; Divisor
    idiv rbx                   ; RAX = quotient (7), RDX = remainder (1)
    
    mov rcx, rax               ; Exit with quotient
    call ExitProcess
main ENDP

END
```

22 is nonnegative, so `cqo` zeros RDX. `idiv` yields 7 remainder 1. Exit 7.

### Unsigned: zero RDX then `div`

```asm
; Listing 05: Unsigned division with zero-extended dividend
;
; Purpose: Demonstrates proper setup for unsigned division.
; Expected exit code: 14 (quotient of 100/7)
; Expected output: (none)
;
; Build: ml64 /c /Fo05-unsigned-division.obj 05-unsigned-division.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-unsigned-division.exe 05-unsigned-division.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 100               ; Dividend in RAX
    xor rdx, rdx               ; Clear high half (RDX = 0)
    mov rbx, 7                 ; Divisor
    div rbx                    ; RAX = quotient (14), RDX = remainder (2)
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

100 / 7 = 14 remainder 2. Forgetting `xor rdx, rdx` treats leftover RDX as the high half of a 128-bit dividend.

Zero divisor or a quotient that does not fit in 64 bits raises `#DE`. Windows delivers `EXCEPTION_INT_DIVIDE_BY_ZERO` or `EXCEPTION_INT_OVERFLOW`. Check the divisor in early lessons rather than installing an exception handler.

## FLAGS

```asm
; Listing 06: FLAGS demonstration
;
; Purpose: Show how arithmetic sets ZF, SF, CF, OF.
; Expected exit code: 0
; Expected output: (none)
;
; Build: ml64 /c /Fo06-flags-demo.obj 06-flags-demo.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-flags-demo.exe 06-flags-demo.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Zero flag: result is zero
    mov rax, 5
    sub rax, 5                 ; RAX = 0, ZF = 1
    
    ; Sign flag: result is negative
    mov rbx, 10
    sub rbx, 20                ; RBX = -10, SF = 1
    
    ; Carry flag: unsigned overflow
    mov cl, 255
    add cl, 1                  ; CL wraps to 0, CF = 1
    
    ; Overflow flag: signed overflow
    mov al, 127
    add al, 1                  ; AL wraps to -128, OF = 1
    
    xor ecx, ecx
    call ExitProcess
main ENDP

END
```

| Flag | Set when |
|------|----------|
| ZF | Result is zero (`5-5`) |
| SF | Result msb set (`10-20` → −10) |
| CF | Unsigned carry/borrow (`255+1` in 8 bits) |
| OF | Signed overflow (`127+1` in 8-bit signed) |

The last `add al, 1` overwrites AL after CL already wrapped; flags at `ExitProcess` are from that last add, not from the ZF example. The listing is a sequence of demonstrations, not a single flag snapshot at exit.

## `cmp` and `test`

`cmp a, b` computes `a - b`, sets flags, keeps operands. `test a, b` computes `a & b`, sets flags, keeps operands.

```asm
; Listing 07: CMP instruction for comparison
;
; Purpose: Demonstrates CMP setting flags without changing operands.
; Expected exit code: 1 (true, because 10 > 5)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-cmp-instruction.obj 07-cmp-instruction.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-cmp-instruction.exe 07-cmp-instruction.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 10
    mov rbx, 5
    
    cmp rax, rbx               ; Compute RAX - RBX, set flags
                               ; RAX and RBX unchanged
                               ; ZF = 0 (not equal)
                               ; For signed: 10 > 5, so result is positive
    
    ; Use SETG (set if greater, signed) to get boolean
    setg cl                    ; CL = 1 if RAX > RBX (signed)
    movzx rcx, cl
    
    call ExitProcess
main ENDP

END
```

```asm
; Listing 08: TEST instruction for bit testing
;
; Purpose: Demonstrates TEST setting flags with bitwise AND.
; Expected exit code: 1 (bit 2 is set)
; Expected output: (none)
;
; Build: ml64 /c /Fo08-test-instruction.obj 08-test-instruction.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-test-instruction.exe 08-test-instruction.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 0b0101            ; Binary: 0101 (bits 0 and 2 set)
    test rax, 4                ; Test bit 2 (4 = 0b0100)
                               ; Computes RAX & 4, sets flags
                               ; ZF = 0 (result nonzero, bit is set)
    
    setnz cl                   ; CL = 1 if ZF = 0 (bit was set)
    movzx rcx, cl
    
    call ExitProcess
main ENDP

END
```

`test rax, rax` is the idiomatic zero check (`cmp rax, 0` but shorter). `test` also clears CF and OF.

MASM accepts `0b0101` as a binary immediate in this listing. If an older ml64 rejects it, that is a listings/toolchain issue — flagged, not edited.

## `setcc`

Destination is always 8-bit. Zero-extend with `movzx` for a 64-bit boolean.

```asm
; Listing 09: SETcc family of instructions
;
; Purpose: Demonstrates various SETcc instructions.
; Expected exit code: 3 (three conditions true)
; Expected output: (none)
;
; Build: ml64 /c /Fo09-setcc-family.obj 09-setcc-family.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-setcc-family.exe 09-setcc-family.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rax, rax               ; Counter = 0
    
    ; Test 1: equality
    mov rbx, 5
    cmp rbx, 5
    sete cl                    ; CL = 1 if equal
    movzx rcx, cl
    add rax, rcx               ; Count += 1
    
    ; Test 2: less than (signed)
    mov rbx, 3
    cmp rbx, 10
    setl cl                    ; CL = 1 if 3 < 10 (signed)
    movzx rcx, cl
    add rax, rcx               ; Count += 1
    
    ; Test 3: greater than (unsigned)
    mov rbx, 10
    cmp rbx, 5
    seta cl                    ; CL = 1 if 10 > 5 (unsigned)
    movzx rcx, cl
    add rax, rcx               ; Count += 1, total = 3
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

| Instruction | Condition |
|-------------|-----------|
| `sete` / `setz` | ZF=1 |
| `setne` / `setnz` | ZF=0 |
| `setl` / `setg` | signed < / > |
| `setle` / `setge` | signed ≤ / ≥ |
| `setb` / `seta` | unsigned below / above |
| `setbe` / `setae` | unsigned ≤ / ≥ |

## Worked example: signed division setup

Listing `04-signed-division` is the complete signed-divide program: dividend 22, divisor 3, `cqo`, `idiv`, exit with quotient 7.

**Step-by-step:**

1. `sub rsp, 32` — shadow space for `ExitProcess`.
2. `mov rax, 22` — dividend in RAX.
3. `cqo` — bit 63 of RAX is 0, so RDX becomes 0. `rdx:rax` is the 128-bit signed 22.
4. `mov rbx, 3` — divisor in RBX (nonvolatile, unused after `idiv` because `main` does not return).
5. `idiv rbx` — RAX=7, RDX=1.
6. `mov rcx, rax` — RCX=7.
7. `call ExitProcess` — process exit code 7.

If the dividend were −42, `cqo` would fill RDX with ones. `idiv` by 5 would put −8 in RAX and −2 in RDX (truncation toward zero). `ExitProcess` takes a UINT; cmd `%ERRORLEVEL%` would show `4294967288` for −8; PowerShell `$LASTEXITCODE` may show −8.

### A plausible wrong reading (and why it fails)

*"22 is positive, so I can skip `cqo` and leave RDX alone."*

**Why it fails:** `idiv` always consumes 128-bit `rdx:rax`. If RDX is leftover 1, the dividend is `2^64 + 22`, not 22. The quotient does not fit in 64 bits and the CPU raises `#DE` (`EXCEPTION_INT_OVERFLOW` on Windows). Always `cqo` before `idiv` for a 64-bit signed dividend; always `xor rdx, rdx` before `div` for a 64-bit unsigned dividend.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `imul` vs `mul` | Signed vs unsigned. Low bits match; high bits differ for negatives. |
| `idiv` vs `div` | `cqo` vs zero RDX. |
| CF vs OF | Unsigned carry vs signed overflow. |
| `cmp` vs `test` | Subtract vs AND; both discard the result. |
| `setl` vs `setb` | Signed less vs unsigned below. |
| `inc` vs `add reg, 1` | `inc` does not update CF. |
| `mov eax, -1` | Zero-extends to `0x00000000FFFFFFFF`, not −1 in RAX. Use `movsxd`/`cdqe` to sign-extend. |

## Check yourself

1. After `add rax, rbx`, which flag is unsigned overflow? Signed overflow?
2. Unsigned divide RAX by 10: what must you do to RDX first?
3. In listing `04-signed-division`, what is in RDX after `idiv`? After `cqo` before `idiv`?
4. Why does `test rax, rax` then ZF tell you whether RAX is zero?
5. After `cmp rax, rbx`, which `setcc` sets AL if RAX > RBX signed?

## Key takeaways

- Arithmetic updates ZF, SF, CF, OF.
- Signed vs unsigned multiply/divide are different instructions.
- `cqo` before `idiv`; `xor rdx, rdx` before `div`.
- `cmp` subtracts; `test` ANDs; both keep operands.
- `setcc` writes 0 or 1 to an 8-bit register; `movzx` widens it.

## Lookup (reference only, not curriculum)

- Intel SDM Volume 2: `add`, `sub`, `imul`, `mul`, `idiv`, `div`, `cqo`, `setcc`
- Intel SDM Volume 1: RFLAGS
- Windows SEH: https://learn.microsoft.com/en-us/windows/win32/debug/structured-exception-handling

## Exercises

Work in `exercises/`. Quoted listings are `lessons/02-arithmetic-flags/listings/01-basic-arithmetic.asm` through `09-setcc-family.asm`.
