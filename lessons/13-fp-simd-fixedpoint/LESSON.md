# Lesson 13 — Fixed-point Arithmetic

Lesson 12's compiler operated on integers. Positions, velocities, and blend weights need fractions. This lesson represents a fraction as an integer with a fixed number of fraction bits: **Q16.16** (16 integer bits, 16 fraction bits). There is no `addss`, no XMM register, and no x87 in the Jack listings. You shift, add, multiply, compare, and wrap on EAX/RAX.

Every listing is a complete MASM program. Status is ECX to `ExitProcess`. Build from an x64 Native Tools prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

## What this lesson asks of you

Encode integer *n* as `n` shifted left 16, and decode with an arithmetic shift right 16 so the sign survives. Add two Q16.16 values with a plain `add` (the scale stays). Multiply two Q16.16 values with `imul`, then shift right 16 to return to Q16.16 — and a second shift right 16 if you want the integer for `ExitProcess`. Clamp with a compare and a move. Wrap a tick or angle by subtracting the period when you cross it.

## Why fixed-point for the later milestones

Lesson 16's sprites and lesson 17's pathfinding want sub-pixel positions and interpolation. Fixed-point gives you:

- **Determinism.** The same integer ops on every CPU.
- **No FP environment.** No rounding-mode surprises, no NaN.
- **The ALU you already have.** Shifts and `imul` from lessons 02 and 07.

Modern games often use hardware floats. You still need Q-format when you want bit-exact replay or when you are not touching SSE yet.

## Q16.16: integer bits and fraction bits

A **Q-format** number is an integer whose low *n* bits are the fraction. **Q16.16** is 32 bits: 16 integer, 16 fraction.

| Value | Q16.16 (hex) | Integer bits . fraction bits |
|------:|-------------:|------------------------------|
| 0.0 | `00000000h` | `0000000000000000.0000000000000000` |
| 1.0 | `00010000h` | `0000000000000001.0000000000000000` |
| 0.5 | `00008000h` | `0000000000000000.1000000000000000` |
| 1.5 | `00018000h` | `0000000000000001.1000000000000000` |
| 2.5 | `00028000h` | `0000000000000010.1000000000000000` |
| −1.0 | `FFFF0000h` | `1111111111111111.0000000000000000` |

Encode integer *n* with `shl eax, 16`. Encode 0.5 with `1 SHL 15` (high bit of the fraction). Decode the integer part with `sar eax, 16` when the value can be negative; `shr` zero-fills and turns a negative Q value into a large positive integer.

Listing `01-q16-encode` loads 5, shifts left 16 (now `00050000h`), then `sar eax, 16` back to 5. Status **5**.

```asm
; 01-q16-encode.asm: Encode integers in Q16.16 format
; Expected exit: 5
; Expected stdout: (none)
; 5 << 16 = 050000h, then >> 16 = 5, exit 5
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 5
    shl eax, 16
    sar eax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
```

The two shifts cancel for a pure integer. They exist so you can see the encode/decode pair. Between them, EAX is 5.0 in Q16.16.

## Addition keeps the scale

Add two Q16.16 values with integer `add`. Both already have 16 fraction bits, so the sum does too.

Listing `02-q16-add` builds 1.5 and 2.5 at assemble time: `(1 SHL 16) + (1 SHL 15)` and `(2 SHL 16) + (1 SHL 15)`. `SHL` here is the MASM operator, not the `shl` instruction. `add eax, ebx` yields 4.0 (`00040000h`). `shr eax, 16` converts that to the integer 4 for the process status. Status **4**.

```asm
; 02-q16-add.asm: Add two Q16.16 values (1.5 + 2.5 = 4.0)
; Expected exit: 4
; Expected stdout: (none)
; Exit 4
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, (1 SHL 16) + (1 SHL 15)
    mov ebx, (2 SHL 16) + (1 SHL 15)
    add eax, ebx
    shr eax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
```

The `shr` is "print as integer," not part of the add. The Q result is already correct after `add`.

## Multiplication doubles the fraction bits

`imul` of two Q16.16 values produces 32 fraction bits (Q32.32 in the 64-bit product). Shift right 16 to return to Q16.16. Shift right 16 *again* if you want the integer.

Listing `03-q16-mul` encodes 2.0 and 3.0, sign-extends both to 64 bits (`movsxd`), multiplies, then `shr rax, 16` twice. After the first shift RAX is `00060000h` (6.0 in Q16.16). After the second it is 6. Status **6**.

```asm
; 03-q16-mul.asm: Multiply Q16.16 values (2.0 * 3.0 = 6.0)
; Expected exit: 6
; Expected stdout: (none)
; Exit 6
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 2
    shl eax, 16
    mov ebx, 3
    shl ebx, 16
    movsxd rax, eax
    movsxd rbx, ebx
    imul rax, rbx
    shr rax, 16
    shr rax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
```

`movsxd` before `imul` matters for negative factors: the 32-bit Q value must fill RAX with a sign, not with zeros in the high half.

These values are positive, so `shr` and `sar` match. A negative product needs `sar` on the 64-bit result (and you must have sign-extended first). `shr rax, 16` on a negative Q32.32 fills the top with zeros and destroys the sign.

## Clamp is a compare, then a move

Clamp *x* to a maximum: if `x > max`, `x = max`. Listing `04-q16-clamp` does that on the **integers** 150 and 100, not on Q16.16 encodings. 150 compared to 100 takes `mov rax, rbx`, so RAX becomes 100. Status **100**.

The comment says "Clamp Q16.16 value to range [0, max]" and "Clamp 150 to [0, 100]". There is no `shl`/`sar` pair. The algorithm is the same one you would use on Q values (`cmp` / `jle` / `mov`); the stored numbers here are 150 and 100, not `150 SHL 16`.

```asm
; 04-q16-clamp.asm: Clamp Q16.16 value to range [0, max]
; Expected exit: 100
; Expected stdout: (none)
; Clamp 150 to [0, 100], exit 100
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov rax, 150
    mov rbx, 100
    cmp rax, rbx
    jle no_clamp
    mov rax, rbx
no_clamp:
    mov ecx, eax
    call ExitProcess
main ENDP
END
```

A lower bound is the symmetric test against 0 (or against `min`): if `x < min`, `x = min`.

## Tick / angle wrap

A periodic counter wraps when it meets or passes the period. Listing `05-tick-wrap` adds 20 to 350, compares to 360, and subtracts 360 because 370 is not less than 360. EAX is 10. Status **10**.

```asm
; Listing 05: Counter wrap after threshold (LESSON.md block 5)
; Expected exit: 10
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, 350
    add     eax, 20
    cmp     eax, 360
    jl      done
    sub     eax, 360
done:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

The compare is `jl done` (signed). 370 − 360 = 10. A value already below 360 would skip the subtract. Two full periods (370 + 360) would need a loop or a divide; this listing subtracts once.

The same pattern wraps a heading: 350° + 20° = 10°.

## Q16 divide, lerp, and an SSE2 lane sum

**Divide.** Naive `idiv` of two Q16.16 values cancels the scales and leaves an integer quotient (`6.0/2.0` → 3 with zero fraction bits; `1.0/2.0` → 0). Widen the dividend first: sign-extend, `shl rax, 16`, `cqo`, `idiv` the divisor. The quotient is Q16.16. Use `sar` if you then convert a signed quotient to an integer.

Listing `06-q16-divide` does that for 6.0 / 2.0: `eax = 6 SHL 16`, `ebx = 2 SHL 16`, `movsxd` both, `shl rax, 16`, `cqo` / `idiv rbx`. The quotient is `3 SHL 16`. One `shr rax, 16` drops the fraction so ECX is the integer 3. Expected exit: **3**. RBX is saved: `push rbx` / `sub rsp, 32`.

```asm
; Listing 06: Q16.16 divide 6.0 / 2.0 with widened dividend
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    mov     eax, 6
    shl     eax, 16
    mov     ebx, 2
    shl     ebx, 16
    movsxd  rax, eax
    shl     rax, 16
    movsxd  rbx, ebx
    cqo
    idiv    rbx
    shr     rax, 16
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

**Lerp.** `result = a + (b - a) * t` with *t* such that `t >= 0 && t <= 1` in Q16. For `a = 0` this is `b * t`. `t = 1 SHL 15` is 0.5 in Q16.16. The product has 32 fraction bits; shifts of 16 return toward an integer.

Listing `07-lerp-fixed` loads `a = 0` into EAX and never uses it again. It encodes `b = 10 SHL 16` and `t = 1 SHL 15`, `imul`s those two (`10.0 * 0.5` with 32 fraction bits), then `shr rax, 16` twice. The integer 5 remains. Expected exit: **5**. There is no `(b - a)` subtract because `a` is 0.

```asm
; Listing 07: Q16 lerp(0, 10, t=0.5) -> 5
; Expected exit: 5
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, 0
    mov     ebx, 10
    shl     ebx, 16
    mov     ecx, 1
    shl     ecx, 15
    movsxd  rax, ebx
    movsxd  rdx, ecx
    imul    rax, rdx
    shr     rax, 16
    shr     rax, 16
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
```

**Length squared.** Compare `x*x + y*y` to `r*r`. Do not take a square root just to test "inside the circle." There is still no `listings/` file. Exercise `14-vec2-length2` (and its solution) computes 3² + 4² and exits **25**.

**Q8.8.** Eight integer bits and eight fraction bits. Multiply two Q8.8 values and `shr` 8 to stay in Q8.8, or `shr` 16 to take the integer. There is still no `listings/` file. Exercises `08-from-scratch-q8` (1.5 × 2, integer **3**) and `24-from-scratch-q8-mul` (2.5 × 2, integer **5**) both `imul` then `shr` 16.

**SSE2 horizontal sum.** Listing `08-simd-lane-sum` loads four DWORDs `[1, 2, 3, 4]` into XMM0 (`movdqu`). `pshufd` with `4Eh` swaps the 64-bit halves to `[3, 4, 1, 2]`; `paddd` yields `[4, 6, 4, 6]`. `pshufd` with `0B1h` swaps adjacent dwords to `[6, 4, 6, 4]`; `paddd` yields `[10, 10, 10, 10]`. `movd ecx, xmm0` takes lane 0. Expected exit: **10**. This is an integer `paddd` reduction, not `addss`.

```asm
; Listing 08: SSE2 horizontal sum of four 32-bit lanes
; Expected exit: 10
; Expected stdout: (none)
;
; Lane trace (lane0 .. lane3), v = [1, 2, 3, 4]:
;   movdqu xmm0 -> [1, 2, 3, 4]
;   pshufd xmm1, xmm0, 4Eh -> [3, 4, 1, 2]
;   paddd xmm0, xmm1       -> [4, 6, 4, 6]
;   pshufd xmm1, xmm0, 0B1h -> [6, 4, 6, 4]
;   paddd xmm0, xmm1       -> [10, 10, 10, 10]; movd ecx, xmm0 -> 10

.DATA
ALIGN 16
v DWORD 1, 2, 3, 4

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    movdqu  xmm0, XMMWORD PTR v
    movdqa  xmm1, xmm0
    pshufd  xmm1, xmm1, 4Eh
    paddd   xmm0, xmm1
    movdqa  xmm1, xmm0
    pshufd  xmm1, xmm1, 0B1h
    paddd   xmm0, xmm1
    movd    ecx, xmm0
    call    ExitProcess
main ENDP
END
```

## Worked example: why listing 03 shifts twice

**Task.** Listing `03-q16-mul` computes 2.0 × 3.0. After `imul`, how many fraction bits does RAX hold, and why are there two `shr rax, 16` instructions?

**Arithmetic.** 2.0 is `2 SHL 16`. 3.0 is `3 SHL 16`. The product is `6` with 32 fraction bits: `6 SHL 32` in the 64-bit register.

**First `shr rax, 16`.** Drop 16 fraction bits. RAX is `6 SHL 16` — 6.0 in Q16.16. That is the multiply result you keep if the next consumer is also Q16.16.

**Second `shr rax, 16`.** Drop the remaining 16 fraction bits. RAX is the integer 6. `mov ecx, eax` / `ExitProcess` yields status **6**.

**Plausible wrong reading.** *"Multiply needs one shift, like the textbook Q16 rule, so the status is the low byte of `6 SHL 16`, which is 0."*

**Why it fails.** The textbook rule produces Q16.16, not an integer exit code. Listing 03 wants the integer 6, so it shifts twice. Listing 02 also shifts once after add — same "print as integer" step. Listing 01 uses `sar` for that decode because encode/decode of a signed integer should copy the sign bit.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| Add needs a shift to stay Q16.16 | Add keeps 16 fraction bits. The `shr` in listing 02 is only to exit 4. |
| One `shr` after `imul` leaves integer 6 | One `shr` leaves `6 SHL 16`. Listing 03 shifts twice to exit 6. |
| `shr` is fine for every Q value | `shr` zero-fills. Use `sar` (listing 01) when the value can be negative. |
| `1 SHL 15` has 15 fraction bits | It is 0.5 in Q16.16: 16 fraction bits, high bit set. |
| Listing 04 clamps `150 SHL 16` | It compares the integers 150 and 100 and exits 100. The algorithm is the clamp; the format is not Q in that file. |
| `SHL` in `(1 SHL 16)` is the `shl` instruction | That `SHL` is an assemble-time MASM operator. The instruction is `shl eax, 16` in listing 01. |
| SSE drills in the exercise folder execute `addss` | Listing `08-simd-lane-sum` is SSE2 `pshufd` / `paddd` on `[1,2,3,4]` and exits **10**. Treat other SSE names as scalar stubs unless you see the opcode. |

## Check yourself

1. Listing `01-q16-encode`: what is EAX after `shl eax, 16` and before `sar eax, 16`? Why `sar` rather than `shr` if the encoded value were negative?
2. Listing `02-q16-add`: what is EAX immediately after `add eax, ebx`, before the `shr`? What Q value is that?
3. Listing `03-q16-mul`: if you deleted the second `shr rax, 16`, what would `ExitProcess` receive in ECX?
4. You divide `1.0 / 2.0` in Q16.16 with `idiv` and no pre-shift of the dividend. What integer sits in RAX, and why is that not 0.5?
5. Listing `05-tick-wrap`: what happens if EAX is 350 + 20 + 360 (two overflows) and you subtract 360 only once?

## Key takeaways

- Q16.16 encodes *n* as `n SHL 16` and 0.5 as `1 SHL 15`. Listing 01 exits 5 after `shl` / `sar`.
- Addition does not change the scale. Listing 02 adds 1.5 + 2.5 and exits the integer 4.
- Multiplication produces 32 fraction bits. One shift returns to Q16.16; listing 03 shifts twice and exits 6.
- Clamp is `cmp` then a conditional move. Listing 04 exits 100 for integer 150 against 100.
- Wrap is compare against the period and subtract. Listing 05 exits 10 for 350 + 20 against 360.
- Decode signed Q values with `sar`, not `shr`.
- Q16 divide widens the dividend (`shl rax, 16` then `idiv`). Listing `06-q16-divide` is 6.0 / 2.0 and exits **3**.
- Lerp with `a = 0` is `b * t`. Listing `07-lerp-fixed` is 10.0 × 0.5 and exits **5**.
- Listing `08-simd-lane-sum` reduces `[1, 2, 3, 4]` with `pshufd` / `paddd` and exits **10**.

## Lookup

- Q format: [Q (number format)](https://en.wikipedia.org/wiki/Q_(number_format))
- `SHL` / `SHR` / `SAR` / `IMUL` / `IDIV` / `CQO`: Intel SDM Volume 2
- Linear interpolation: [Linear interpolation](https://en.wikipedia.org/wiki/Linear_interpolation)
- Microsoft x64: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
echo %ERRORLEVEL%
```

Q-format: encode 5, add 1.5 + 2.5, multiply 2.0 × 3.0 (watch how many shifts you take before `ExitProcess`), Q8.8 multiplies, lerp toward 10.0 with t = 0.5, divide 6.0 / 2.0 with a widened dividend.

Geometry: clamp, dot2, dot3, length squared (25, not 5), angle wrap 350 + 20 → 10.

Scalar stubs named SSE/SIMD: they add in GPRs. Do not invent `addss` to satisfy a filename.
