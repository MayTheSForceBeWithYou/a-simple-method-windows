# Lesson 03 — Control Flow

Arithmetic and data movement are computation; control flow is decision. This lesson teaches you to compare values and branch, turning a straight-line sequence into if/else, while, for, and early exit. You will distinguish signed jumps (`jl`, `jg`) from unsigned jumps (`jb`, `ja`). Jump tables remain a conceptual tool here — there is no standalone jump-table listing on the listings branch.

These instructions are platform-independent. The Windows wrapper is still `main PROC`, 32-byte shadow space, `call ExitProcess`.

## What this lesson asks of you

Use `cmp` or `test` then a `jcc`. Implement if, if/else, while, counted for, and break. Choose signed vs unsigned jumps for the data type. Trace loop bounds so you do not miss or double-count an endpoint.

## Conditional jumps

| Instruction | Condition |
|-------------|-----------|
| `je` / `jz` | ZF=1 |
| `jne` / `jnz` | ZF=0 |
| `jl` / `jg` / `jle` / `jge` | signed < > ≤ ≥ |
| `jb` / `ja` / `jbe` / `jae` | unsigned below / above |

"Less/greater" is signed. "Below/above" is unsigned. `jmp` always jumps.

## If

```asm
; Listing 01: Simple if statement
;
; Purpose: Demonstrate conditional execution with JE.
; Expected exit code: 10 (if path taken)
; Expected output: (none)
;
; Build: ml64 /c /Fo01-simple-if.obj 01-simple-if.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-simple-if.exe 01-simple-if.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 5
    mov rbx, 5
    mov rcx, 99                ; Default exit code
    
    cmp rax, rbx
    jne skip_then              ; If not equal, skip
    
    ; Then branch (rax == rbx)
    mov rcx, 10
    
skip_then:
    call ExitProcess
main ENDP

END
```

RAX equals RBX, so `jne` falls through, RCX becomes 10, exit 10. If they differed, RCX would stay 99.

## If-else

```asm
; Listing 02: If-else statement
;
; Purpose: Demonstrate if-else with signed comparison.
; Expected exit code: 20 (else path, since 10 is not negative)
; Expected output: (none)
;
; Build: ml64 /c /Fo02-if-else.obj 02-if-else.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-if-else.exe 02-if-else.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 10
    
    cmp rax, 0
    jge else_branch            ; If RAX >= 0, jump to else
    
    ; Then branch: RAX < 0
    mov rcx, 10
    jmp end_if
    
else_branch:
    ; Else branch: RAX >= 0
    mov rcx, 20
    
end_if:
    call ExitProcess
main ENDP

END
```

The `then` path must `jmp end_if` or it would fall into `else`. 10 ≥ 0, so exit 20.

## While

```asm
; Listing 03: While loop
;
; Purpose: Demonstrate while loop summing numbers.
; Expected exit code: 15 (1+2+3+4+5)
; Expected output: (none)
;
; Build: ml64 /c /Fo03-while-loop.obj 03-while-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-while-loop.exe 03-while-loop.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rax, rax               ; Sum = 0
    mov rcx, 5                 ; Counter = 5
    
loop_start:
    cmp rcx, 0
    jle loop_done              ; While rcx > 0
    
    add rax, rcx               ; sum += counter
    dec rcx
    jmp loop_start
    
loop_done:
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Comment says "While rcx > 0"; the code exits with `jle` when RCX ≤ 0. That is the same predicate. Sum 5+4+3+2+1 = 15. After the last add, RCX is overwritten with the sum for `ExitProcess`.

## For (counted)

```asm
; Listing 04: For loop (counted iteration)
;
; Purpose: Demonstrate for-style loop from 0 to N-1.
; Expected exit code: 10 (sum of 0+1+2+3+4)
; Expected output: (none)
;
; Build: ml64 /c /Fo04-for-loop.obj 04-for-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-for-loop.exe 04-for-loop.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rax, rax               ; Sum = 0
    xor rcx, rcx               ; Index = 0
    mov r8, 5                  ; Limit = 5
    
loop_start:
    cmp rcx, r8
    jge loop_done              ; While index < limit
    
    add rax, rcx               ; sum += index
    inc rcx
    jmp loop_start
    
loop_done:
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

This is `for (i = 0; i < 5; i++) sum += i`. Condition `jge` after `cmp i, n` is the C `<` test. Sum 10.

## Signed vs unsigned

−1 as signed is less than 1. As unsigned it is `0xFFFFFFFFFFFFFFFF`, above 1.

```asm
; Listing 05: Signed vs unsigned comparison
;
; Purpose: Show different results for JL vs JB with same values.
; Expected exit code: 2 (both branches increment)
; Expected output: (none)
;
; Build: ml64 /c /Fo05-signed-vs-unsigned.obj 05-signed-vs-unsigned.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-signed-vs-unsigned.exe 05-signed-vs-unsigned.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rcx, rcx               ; Counter = 0
    
    ; Compare -1 with 1
    mov rax, -1                ; All bits set (signed: -1, unsigned: huge)
    mov rbx, 1
    
    ; Signed comparison: -1 < 1
    cmp rax, rbx
    jge not_less_signed
    inc rcx                    ; Count this
not_less_signed:
    
    ; Unsigned comparison: -1 (huge) > 1
    cmp rax, rbx
    jbe not_greater_unsigned
    inc rcx                    ; Count this
not_greater_unsigned:
    
    call ExitProcess
main ENDP

END
```

Both increments run. Exit 2. If you used `jl` for the second test you would skip the unsigned increment.

## Early exit (break)

```asm
; Listing 06: Early loop exit with break
;
; Purpose: Demonstrate breaking out of loop early.
; Expected exit code: 3 (stops when counter == 3)
; Expected output: (none)
;
; Build: ml64 /c /Fo06-early-exit.obj 06-early-exit.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-early-exit.exe 06-early-exit.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rcx, rcx               ; Counter = 0
    
loop_start:
    inc rcx
    
    cmp rcx, 3
    je loop_done               ; Break when counter == 3
    
    cmp rcx, 10
    jl loop_start              ; Continue if counter < 10
    
loop_done:
    call ExitProcess
main ENDP

END
```

RCX goes 1, 2, 3. At 3, `je loop_done` fires. Exit code is 3 (RCX is already the first argument). The `cmp rcx, 10` bound is never reached.

## Zero check with `test`

```asm
; Listing 07: Idiomatic zero check with TEST
;
; Purpose: Demonstrate TEST for checking if register is zero.
; Expected exit code: 1 (rdi is nonzero)
; Expected output: (none)
;
; Build: ml64 /c /Fo07-test-zero-check.obj 07-test-zero-check.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-test-zero-check.exe 07-test-zero-check.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rdi, 42
    
    test rdi, rdi
    jz is_zero                 ; Jump if zero
    
    ; Nonzero path
    mov rcx, 1
    jmp end_check
    
is_zero:
    xor ecx, ecx
    
end_check:
    call ExitProcess
main ENDP

END
```

42 is nonzero, so exit 1. RDI is nonvolatile; `main` does not return.

## Jump tables (no listing on this branch)

A jump table is an array of code addresses. After a bounds check, `jmp QWORD PTR [table + rax*8]` dispatches. Without the bounds check, an out-of-range index loads a garbage RIP. There is no `jump-table.asm` listing yet; do not invent a filename.

## Worked example: while-sum

Listing `03-while-loop` is the full program. Shadow space, sum in RAX, counter in RCX from 5 down to 1.

| Iteration | RCX at `add` | RAX after `add` | RCX after `dec` |
|-----------|--------------|-----------------|-----------------|
| 1 | 5 | 5 | 4 |
| 2 | 4 | 9 | 3 |
| 3 | 3 | 12 | 2 |
| 4 | 2 | 14 | 1 |
| 5 | 1 | 15 | 0 |

Then `cmp rcx, 0` / `jle loop_done`. `mov rcx, rax` then exit 15.

### A plausible wrong reading (and why it fails)

*"I should use `jg loop_done` after `cmp rcx, 0` because the loop is while counter is positive."*

**Why it fails:** `jg` exits when RCX > 0, so the body never runs. The listing uses `jle loop_done` (exit when ≤ 0), which is `while (rcx > 0)`. Using `jl` instead of `jle` would also work here because RCX hits 0 exactly, but `jle` is the direct translation of "not greater than 0."

For a C `for (i = 0; i < n; i++)`, the matching jump after `cmp i, n` is `jge done`, not `jg done`. `jg` includes `i == n` as a live iteration (off-by-one).

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| `jl` vs `jb` | Signed vs unsigned. −1 < 1 signed; −1 above 1 unsigned. |
| `je` vs `jz` | Synonyms (ZF=1). |
| `jge` vs `jg` | Inclusive vs exclusive bound. Off-by-one. |
| Operand order of `cmp` | `cmp a, b; jl` is a < b. |
| `test reg, reg` vs `cmp reg, 0` | Same ZF; `test` is shorter. |

## Check yourself

1. Signed `if (x > 10) then else`. After `cmp rax, 10`, which jump skips `then`?
2. `for (i = 0; i < 100; i++)` with RCX. After `cmp rcx, 100`, which of `jge`/`jg`/`jle`/`jl` matches?
3. Listing `04-for-loop`: if you change `jge` to `jg`, what is the new exit code?
4. After `test rdi, 1` with RDI=5, does `jz` jump?
5. In listing `05-signed-vs-unsigned`, what happens to the second increment if you replace `jbe` with `jge`?

## Key takeaways

- `jcc` reads flags from `cmp`/`test`. Signed vs unsigned mnemonics are not interchangeable.
- If/else needs a jump around the else. Loops jump back. Break jumps to the done label.
- `test reg, reg` / `jz` is the zero idiom.
- Trace the bound values. `jge` vs `jg` is a one-iteration bug.

## Lookup (reference only, not curriculum)

- Intel SDM Volume 2, Jcc
- MASM labels: procedure-scoped by default

## Exercises

Work in `exercises/`. Quoted listings are `01-simple-if.asm` through `07-test-zero-check.asm`.
