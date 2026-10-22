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
    sub rsp, 40
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
    sub rsp, 40
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
    sub rsp, 40
    
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
; Expected exit: 15
; Expected stdout: (none)
;
; Build: ml64 /c /Fo04-recursive-sum.obj 04-recursive-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-recursive-sum.exe 04-recursive-sum.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_to PROC FRAME
    push rcx                   ; Save n on stack across recursive call (rcx is volatile)
    .pushreg rcx
    sub rsp, 40
    .allocstack 40
    .endprolog
    
    cmp rcx, 0
    jg recursive
    xor eax, eax               ; Base case: return 0
    jmp done
    
recursive:
    dec rcx
    call sum_to
    add rax, [rsp+40]          ; Add saved n (still on stack below shadow)
    jmp done
    
done:
    add rsp, 40
    pop rcx
    ret
sum_to ENDP

main PROC
    sub rsp, 40
    mov rcx, 5
    call sum_to
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

The push comment is explicit: RCX is **volatile**. Saving `n` on the stack is not ABI preservation of a callee-saved register; it is how this listing keeps the argument across the recursive `call`. `.pushreg rcx` still describes that push to the unwinder.

Both the base path and the recursive path `jmp done`. The shared epilogue is `add rsp, 40` / `pop rcx` / `ret`. After `push rcx` then `sub rsp, 40`, the saved `n` lives at `[rsp+40]`, so the recursive path adds it with `add rax, [rsp+40]` *before* tearing the frame down.

That frame is **not** the model to copy. At procedure entry RSP ≡ 8 (mod 16). One `push` leaves RSP ≡ 0; the aligned allocation after a single push is `sub rsp, 32`, so the recursive `call` sees RSP ≡ 0. `push rcx` plus `sub rsp, 40` leaves RSP ≡ 8 at `call` — misaligned. A corrected listing (1 push + `sub rsp, 32`, saved `n` at `[rsp+32]`) is pending on Jack's PR #5. Quote the file that exists; do not treat `push` + 40 as a correct prologue.

## Tail recursion (concept)

If nothing remains after the recursive call except `ret`, you can `jmp` to the top with updated arguments (a loop). Factorial is **not** tail recursive after `imul`. `sum_to` as written is not tail recursive either (`add` after the call).

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| RCX survives `call` | It does not. Stash in RBX/R12 or a local. |
| Pushing RCX = ABI preserve | RCX is volatile; the push is your private save. |
| Shared epilogue vs split `ret` | Both `factorial` and `sum_to` `jmp done`. `sum_to`'s `done` is `add rsp, 40` / `pop` / `ret` in the current file. |
| `push rcx` + `sub rsp, 40` is aligned | One push needs `sub rsp, 32`. The current listing is misaligned; a fix is pending on PR #5. |
| `leave` | `mov rsp, rbp` / `pop rbp`. |
| Linux RDI argument | Windows RCX. |

## Check yourself

1. In listing `01-factorial`, why `mov rbx, rcx` before `dec rcx`?
2. `sum_locals(10)`: what is at `[rbp-16]` after the three stores?
3. After `call wipe` in listing 03, what is in R12?
4. In listing 04 as quoted, where is saved `n` after `push rcx` / `sub rsp, 40`? Why is that allocation the wrong size after one push?
5. Is `factorial` tail recursive?

## Key takeaways

- Locals live in the frame; `leave` tears a RBP frame down.
- Nonvolatiles (RBX, R12, …) must be saved if used.
- Recursion must stash live volatile arguments before `call`.
- One push plus `sub rsp, 40` is misaligned; after a single push the allocation is `sub rsp, 32`.
- `PROC FRAME` unwind directives belong in the prologue.
- Prefer one epilogue that always deallocates.

## Lookup (reference only, not curriculum)

- https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention
- https://learn.microsoft.com/en-us/cpp/build/exception-handling-x64

## Exercises

Quoted listings: `01-factorial.asm`, `02-multi-local-frame.asm`, `03-callee-saved-r12.asm`, `04-recursive-sum.asm`.
