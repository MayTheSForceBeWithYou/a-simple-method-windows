# Lesson 05 — Procedures & Recursion

Lesson 04 taught a single call. This lesson keeps a frame correct across nested and recursive calls: multiple locals, callee-saved spills, saving a live argument that lives in a volatile register, and unwind-aware prologues.

## What this lesson asks of you

Allocate shadow space plus locals. Save RBX, RBP, RDI, RSI, R12–R15 if you use them. RCX, RDX, R8, R9 are **volatile** — a recursive `call` clobbers them; stash `n` in a nonvolatile (RBX in the factorial listing) or on the stack before the call. Maintain 16-byte alignment. Tail recursion can become a loop; that rewrite is conceptual here.

## Multi-local frames

`call` enters with RSP ≡ 8 (mod 16). `push rbp` makes it ≡ 0. Three qwords are 24 bytes; `sub rsp, 32` pads. Locals at `[rbp-8]`, `[rbp-16]`, `[rbp-24]`. `leave` is `mov rsp, rbp` / `pop rbp`.

```asm
; Listing 02: Multi-local stack frame (lines 14-40 of LESSON.md)
;
; Purpose: sum_locals(n) stores n, n+1, n+2 as locals and returns sum.
; Expected exit code: 33 (10+11+12)
; Expected output: (none)
;
; Build: ml64 /c /Fo02-multi-local-frame.obj 02-multi-local-frame.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-multi-local-frame.exe 02-multi-local-frame.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_locals PROC FRAME
    push rbp
    .pushreg rbp
    mov rbp, rsp
    sub rsp, 32                ; 24 bytes locals + 8 alignment
    .allocstack 32
    .endprolog
    
    mov [rbp-8], rcx           ; local1 = n
    lea rax, [rcx+1]
    mov [rbp-16], rax          ; local2 = n+1
    lea rax, [rcx+2]
    mov [rbp-24], rax          ; local3 = n+2
    
    mov rax, [rbp-8]
    add rax, [rbp-16]
    add rax, [rbp-24]
    
    leave
    ret
sum_locals ENDP

main PROC
    sub rsp, 32
    mov rcx, 10
    call sum_locals
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`sum_locals(10)` → 10+11+12 = 33. Argument is RCX, not Linux RDI.

## Callee-saved spills

R12 is nonvolatile. Wipe it only after `push r12`.

```asm
; Listing 03: Callee-saved register spill (lines 48-64 of LESSON.md)
;
; Purpose: Function using R12 must preserve it.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo03-callee-saved-r12.obj 03-callee-saved-r12.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-callee-saved-r12.exe 03-callee-saved-r12.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

wipe PROC FRAME
    push r12                   ; Save nonvolatile R12
    .pushreg r12
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    xor r12, r12               ; Use R12 temporarily
    
    add rsp, 32
    pop r12                    ; Restore R12
    ret
wipe ENDP

main PROC
    sub rsp, 32
    mov r12, 42
    call wipe
    mov rcx, r12               ; Still 42 (preserved)
    call ExitProcess
main ENDP

END
```

Main puts 42 in R12, `wipe` zeros R12 then restores it, exit 42.

## Worked example: recursive factorial

```asm
; Listing 01: Recursive factorial
;
; Purpose: Demonstrate recursion with proper stack management.
; Expected exit code: 120 (5!)
; Expected output: (none)
;
; Build: ml64 /c /Fo01-factorial.obj 01-factorial.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-factorial.exe 01-factorial.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; factorial(n): returns n!
; Base case: n <= 1 returns 1
; Recursive: n * factorial(n-1)
factorial PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    cmp rcx, 1
    jg recursive
    mov rax, 1                 ; Base case: return 1
    jmp done
    
recursive:
    mov rbx, rcx               ; Save n
    dec rcx                    ; n-1
    call factorial             ; factorial(n-1) in RAX
    imul rax, rbx              ; n * factorial(n-1)
    
done:
    add rsp, 32
    pop rbx
    ret
factorial ENDP

main PROC
    sub rsp, 32
    
    mov rcx, 5
    call factorial             ; 5! = 120
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

For `n = 5`: RBX saves 5, recursive call with RCX=4, multiply 24×5=120. Both base and recursive paths share the same epilogue (`done`). RBX is the right stash: it survives the recursive `call`; RCX would not.

`0!` is usually 1. This listing treats `n <= 1` as 1, so `factorial(0)` also returns 1. Fine for 5!.

### A plausible wrong reading (and why it fails)

*"RCX still holds n after `call factorial`, so I do not need RBX."*

**Why it fails:** RCX is volatile. The recursive `factorial` uses RCX as its argument and does not restore it for the caller. Without RBX (or a stack slot), `imul rax, rcx` multiplies by leftover garbage. Listing `01-factorial` copies `n` to RBX **before** `dec rcx` / `call`.

## Recursive sum (stack save)

```asm
; Listing 04: Recursive sum_to (lines 70-94 of LESSON.md)
;
; Purpose: sum_to(n) = n + sum_to(n-1), base case 0.
; Expected exit code: 15 (1+2+3+4+5)
; Expected output: (none)
;
; Build: ml64 /c /Fo04-recursive-sum.obj 04-recursive-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-recursive-sum.exe 04-recursive-sum.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_to PROC FRAME
    push rcx                   ; Save RCX (nonvolatile preservation)
    .pushreg rcx
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    cmp rcx, 0
    jg recursive
    xor eax, eax               ; Base case: return 0
    jmp done
    
recursive:
    dec rcx
    call sum_to
    pop rcx                    ; Restore original n
    add rax, rcx               ; Add n to sum(n-1)
    ret
    
done:
    add rsp, 32
    pop rcx
    ret
sum_to ENDP

main PROC
    sub rsp, 32
    mov rcx, 5
    call sum_to
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Header comment says "Save RCX (nonvolatile preservation)". RCX is **volatile**. Pushing it is a way to keep `n` across the call, not ABI preservation of a callee-saved register.

The **recursive** path does `pop rcx` / `ret` without `add rsp, 32`. After `sub rsp, 32`, that `pop` reads the shadow space, not the saved RCX. The **base** path does `add rsp, 32` then `pop rcx`. Treat listing 04 as a contrast with listing 01's shared epilogue. Flagged in `docs/PROSE_TECH_FLAGS.md`. Do not "fix" the listing in prose by rewriting it.

## Tail recursion (concept)

If nothing remains after the recursive call except `ret`, you can `jmp` to the top with updated arguments (a loop). Factorial is **not** tail recursive after `imul`. `sum_to` as written is not tail recursive either (`add` after the call).

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| RCX survives `call` | It does not. Stash in RBX/R12 or a local. |
| Pushing RCX = ABI preserve | RCX is volatile; the push is your private save. |
| Shared epilogue vs split `ret` | Factorial shares `done`. `sum_to` splits paths; the recursive path omits `add rsp, 32`. |
| `leave` | `mov rsp, rbp` / `pop rbp`. |
| Linux RDI argument | Windows RCX. |

## Check yourself

1. In listing `01-factorial`, why `mov rbx, rcx` before `dec rcx`?
2. `sum_locals(10)`: what is at `[rbp-16]` after the three stores?
3. After `call wipe` in listing 03, what is in R12?
4. Does the recursive path of listing 04 deallocate the 32-byte frame before `pop rcx`?
5. Is `factorial` tail recursive?

## Key takeaways

- Locals live in the frame; `leave` tears a RBP frame down.
- Nonvolatiles (RBX, R12, …) must be saved if used.
- Recursion must stash live volatile arguments before `call`.
- `PROC FRAME` unwind directives belong in the prologue.
- Prefer one epilogue that always deallocates.

## Lookup (reference only, not curriculum)

- https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention
- https://learn.microsoft.com/en-us/cpp/build/exception-handling-x64

## Exercises

Quoted listings: `01-factorial.asm`, `02-multi-local-frame.asm`, `03-callee-saved-r12.asm`, `04-recursive-sum.asm`.
