# Lesson 05 — Procedures & Recursion

Lesson 04 taught you how to call a function once. This lesson teaches you how to write functions that maintain correct state when they call other functions — including themselves. You will allocate multiple local variables in a stack frame, save and restore callee-saved registers you modify, and implement recursion by preserving arguments across calls. You will also recognize when recursion can be replaced with a loop (tail recursion), and when mutual recursion between two functions can be implemented with `jmp` instead of `call` to avoid growing the stack unnecessarily.

## What this lesson asks of you

You must be able to allocate space for shadow space, multiple local variables, and alignment in a function's stack frame and access them relative to `rbp` or `rsp`. You will save any nonvolatile (callee-saved) registers (`rbx`, `rbp`, `rdi`, `rsi`, `r12`–`r15`) you use at the start of your function and restore them before returning, respecting the Microsoft x64 ABI contract. You will implement recursive functions by saving live arguments (like `rcx`) before a recursive `call` — either on the stack or in a nonvolatile register — because argument registers are volatile (caller-saved) and will be clobbered by the call. You must allocate shadow space (32 bytes minimum) before every recursive call and maintain 16-byte stack alignment. You will distinguish tail calls (where no work remains after the recursive call returns) from non-tail recursion, and recognize that tail recursion can be rewritten as a loop. Finally, you will implement mutual recursion (two functions calling each other) using `jmp` when the current stack frame is no longer needed, avoiding unnecessary stack growth.

## Multi-local frames

`call` enters with `rsp ≡ 8 (mod 16)`. `push rbp` makes it `≡ 0`. Three qwords need 24 bytes; `sub rsp, 32` is the pad that keeps that alignment. Locals live at `[rbp-8]`, `[rbp-16]`, `[rbp-24]`. `leave` is `mov rsp, rbp` / `pop rbp`.

`sum_locals(10)` stores `n`, `n+1`, `n+2` and returns 33. Same shape as `exercises/01-locals-three.asm`.

```asm
section .text
global _start

sum_locals:
    push rbp
    mov rbp, rsp
    sub rsp, 32              ; 24 bytes of locals + 8 of alignment
    mov [rbp-8], rdi
    lea rax, [rdi+1]
    mov [rbp-16], rax
    lea rax, [rdi+2]
    mov [rbp-24], rax
    mov rax, [rbp-8]
    add rax, [rbp-16]
    add rax, [rbp-24]
    leave
    ret

_start:
    mov rdi, 10
    call sum_locals
    mov rdi, rax             ; 33
    mov rax, 60
    syscall
```

`sub rsp, 24` would assemble and return 33 here, and break the next `call`. Nested frames (`12-nested-frame.asm`) and a context pointer in `r12` (`17-closure-sim.asm`) use the same prologue.

## Callee-saved spills

You may write `rbx` and `r12`–`r15` only if you `push` them first and `pop` them before `ret`. `rbp` is already your frame. Caller-saved `rax`, `rcx`, `rdx`, `rsi`, `rdi`, `r8`–`r11` die across `call`.

```asm
section .text
global _start

wipe:
    push r12
    xor r12, r12
    pop r12
    ret

_start:
    mov r12, 42
    call wipe
    mov rdi, r12             ; 42, not 0
    mov rax, 60
    syscall
```

That is `05-save-r12.asm`. `09-fib-iter-proc.asm` uses `rbx` and does not save it. Exit status is still 55 because `_start` never reads `rbx` again. The procedure is still wrong.

## Recursion is a spill

`sum_to(n)` is `n + sum_to(n-1)`, and `0` at the base. `rdi` does not survive the recursive `call`. Push it, recurse, pop, then add.

```asm
section .text
global _start

sum_to:
    cmp rdi, 0
    jg .rec
    xor rax, rax
    ret
.rec:
    push rdi
    dec rdi
    call sum_to
    pop rdi
    add rax, rdi
    ret

_start:
    mov rdi, 5
    call sum_to
    mov rdi, rax             ; 15
    mov rax, 60
    syscall
```

Same spill in `08-from-scratch-rec-pow.asm` (`imul` after the pop), `10-gcd-proc.asm` (`div` writes `rax` and `rdx` before the recurse), `04-tree-sum-flat.asm` (index and partial sum, no `rbp`), and `24-from-scratch-rec-sum-array.asm`. `16-debug-missing-pop.asm` is factorial with the pop deleted: `fact(3)` must exit 6 once `pop rdi` sits before `imul`.

`06-ack-lite.asm` is Ackermann with two arguments. The `m=0` and `m>0,n=0` cases are tail calls: stack already balanced, so `jmp ack`. The general case is not: you must hold `m` while `ack(m, n-1)` runs.

## Mutual recursion

`is_even` / `is_odd` never need a new frame. After `dec rdi` the argument is the only live value, so `jmp` the other label. A `call` would push a return address you never use.

```asm
section .text
global _start

is_even:
    test rdi, rdi
    jnz .go
    mov rax, 1
    ret
.go:
    dec rdi
    jmp is_odd

is_odd:
    test rdi, rdi
    jnz .go
    xor rax, rax
    ret
.go:
    dec rdi
    jmp is_even

_start:
    mov rdi, 4
    call is_even
    mov rdi, rax             ; 1
    mov rax, 60
    syscall
```

`02-mutual-even-odd.asm` and `14-mutual-parity-count.asm` are this pattern. The CPU does not turn `call` into `jmp`. If anything is still on the stack (a saved `rdi`, a frame), `jmp` skips the matching `pop` and `ret` goes to the wrong address.

## Recursion to a loop

When the recursive result is only “add n, then the rest”, an accumulator does the same work and the stack stays put. `sum_acc(6)` exits 21, matching `sum_to(6)`.

```asm
section .text
global _start

sum_acc:
    xor rax, rax
.next:
    test rdi, rdi
    jz .done
    add rax, rdi
    dec rdi
    jmp .next
.done:
    ret

_start:
    mov rdi, 6
    call sum_acc
    mov rdi, rax             ; 21
    mov rax, 60
    syscall
```

That is `07-tail-ish-loop.asm`. `18-trampoline-depth.asm` is still real recursion (`bump` increments after the call). Do not rewrite it as this loop.

## Worked example: recursive factorial with proper spill

Let's implement `factorial(n) = n * factorial(n-1)` with base case `factorial(0) = 1`. We must save `rcx` (the argument) across the recursive call because it is volatile (caller-saved) and the call will clobber it. We also need to allocate shadow space before every recursive call.

<!-- LISTING-PENDING: lessons/05-procedures-recursion/listings/factorial.asm -->

```asm
EXTERN ExitProcess:PROC

.code

factorial PROC
    cmp rcx, 0
    jg recurse_case
    mov rax, 1               ; base case: 0! = 1
    ret

recurse_case:
    push rcx                 ; save n (nonvolatile storage)
    sub rsp, 40              ; allocate shadow space (32) + alignment (8)
    
    dec rcx                  ; n-1
    call factorial           ; rax = (n-1)!
    
    add rsp, 40              ; deallocate stack space
    pop rcx                  ; restore n
    imul rax, rcx            ; rax = n * (n-1)!
    ret
factorial ENDP

main PROC
    sub rsp, 40              ; allocate shadow space + alignment
    
    mov rcx, 5
    call factorial           ; rax = 5! = 120
    
    mov ecx, eax             ; exit with 5! = 120
    call ExitProcess
main ENDP
END
```

Build and run:
```cmd
ml64 /c fact.asm
link /OUT:fact.exe /ENTRY:main /SUBSYSTEM:CONSOLE fact.obj kernel32.lib
fact.exe
echo %ERRORLEVEL%   REM prints 120 (5! = 120)
```

Trace `factorial(3)`: `rcx=3`, push 3 (save), allocate 40 bytes shadow+alignment, recurse with `rcx=2`, which pushes 2, allocates shadow, recurses with `rcx=1`, which pushes 1, allocates shadow, recurses with `rcx=0`, which returns 1. Back in `factorial(1)`, deallocate stack, pop 1, multiply `1 * 1 = 1`, return 1. Back in `factorial(2)`, deallocate, pop 2, multiply `2 * 1 = 2`, return 2. Back in `factorial(3)`, deallocate, pop 3, multiply `3 * 2 = 6`, return 6.

Each call saves its argument on the stack (via `push rcx`), allocates shadow space for the recursive call, recurses, deallocates shadow space, restores the argument (`pop rcx`), and multiplies. The stack grows with depth `n` (each frame is 48 bytes: 8 for pushed RCX + 40 for shadow/alignment) and shrinks as each call returns.

### A plausible wrong reading (and why it fails)

A common mistake is to forget the `pop rcx` before `imul`, or to forget to allocate shadow space before the recursive call. Suppose you write:

```asm
recurse_case:
    push rcx
    dec rcx
    call factorial
    ; MISSING: pop rcx before multiply
    imul rax, rcx            ; BUG: rcx still holds n-1, not n
    ret
```

After the recursive call returns, `rcx` holds the *decremented* value (`n-1`), not the original `n`, because you never restored it from the stack. So you compute `(n-1)! * (n-1)` instead of `n! = n * (n-1)!`. For `factorial(3)`, this produces `2 * 2 = 4` instead of `3 * 2 = 6`.

Another common mistake is to forget shadow space:

```asm
recurse_case:
    push rcx
    dec rcx
    call factorial           ; BUG: no shadow space allocated
    pop rcx
    imul rax, rcx
    ret
```

This violates the Microsoft x64 ABI. The called function expects 32 bytes of shadow space to exist at `[rsp]` through `[rsp+31]` (after `call` pushes the return address, these become `[rsp+8]` through `[rsp+39]`). Without it, the stack may be corrupted, causing crashes or silent misbehavior. **Always** allocate shadow space (plus alignment) before every `call`.

The lesson: match every `push` with a `pop` before using the saved value, and allocate shadow space before every call.

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| Volatile vs nonvolatile (caller-saved vs callee-saved) | Volatile registers (`rax`, `rcx`, `rdx`, `r8`–`r11`) are clobbered by any call; the caller must save them if needed. Nonvolatile registers (`rbx`, `rbp`, `rdi`, `rsi`, `r12`–`r15`) must be preserved by the callee if it uses them. **RSI and RDI are nonvolatile on Windows** (opposite of Linux). |
| Shadow space + locals + alignment | You need 32 bytes shadow space + `N` bytes for locals + alignment padding. Total must be a multiple of 16 for correct stack alignment before `call`. Example: 32 shadow + 24 locals = 56, round to 64. |
| `leave` vs `mov rsp, rbp; pop rbp` | They are identical. `leave` is a single instruction that does both. Use `leave` for clarity. |
| Recursive call vs tail call | A recursive call where work remains afterward (like `imul` or `add`) requires saving state, allocating shadow space, and returning. A tail call where no work remains can use `jmp` instead of `call` to reuse the current frame (no shadow space needed for `jmp`). |
| Tail recursion vs loop | Tail recursion can always be rewritten as a loop with an accumulator. The loop avoids stack growth and is more efficient. The compiler does not optimize tail calls automatically; you must rewrite them yourself. |
| `call` vs `jmp` for tail calls | `call` pushes a return address you will immediately pop and return; `jmp` skips this overhead. Use `jmp` for tail calls (after ensuring the stack is balanced). |
| Forgetting to save `rdi` in recursion | Argument registers are caller-saved, so the recursive call clobbers them. If you need the original argument afterward, `push` it before the call and `pop` it after. Forgetting this produces wrong results. |

## Check yourself

1. You allocate space for 5 quadwords (40 bytes) of locals in a function. After `push rbp`, `rsp` is 8 (mod 16). How many bytes should you `sub` from `rsp` to maintain alignment?
2. You write a function that uses `rbx` and `r13`. Which of these must you save and restore, and where in the function do you save them?
3. Trace the stack for `factorial(2)`: what is on the stack at the deepest recursion (inside `factorial(0)`), and what is the stack height (number of return addresses plus saved values)?
4. Why can `is_even` and `is_odd` use `jmp` instead of `call` for mutual recursion? What would go wrong if you used `call` followed immediately by `ret`?
5. Rewrite `countdown(n)` (which prints `n, n-1, ..., 1` by recursing) as a loop. What register holds the accumulator, and how do you avoid recursion?

## Key takeaways

- Functions allocate stack space with `sub rsp, N` where `N` includes 32 bytes shadow space + locals + alignment padding (total multiple of 16); locals are accessed at `[rbp-8]`, `[rbp-16]`, or relative to `rsp`.
- Nonvolatile (callee-saved) registers (`rbx`, `rbp`, `rdi`, `rsi`, `r12`–`r15`) must be pushed at function entry and popped before return if the function modifies them; volatile (caller-saved) registers may be clobbered by any call. **RSI and RDI are nonvolatile on Windows** (opposite of Linux).
- Recursive functions must save live arguments (like `rcx`) before the recursive call because argument registers are volatile; save them on the stack or in a nonvolatile register, and restore afterward.
- Before every recursive `call`, allocate shadow space (32 bytes minimum) plus alignment; deallocate after the call returns.
- Tail calls (where no work remains after the call) can use `jmp` instead of `call` to reuse the current frame and avoid stack growth; the compiler does not optimize this automatically.
- Tail recursion is equivalent to a loop with an accumulator; rewriting it as a loop eliminates recursion overhead and stack growth.
- Every `push` must be matched by a `pop` in reverse order (LIFO); unbalanced stack operations cause `ret` to jump to a garbage address and crash.

## Lookup (reference only, not curriculum)

- **Microsoft x64 calling convention:** https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions (stack usage, shadow space, register preservation)
- **Recursion patterns:** Any assembly textbook chapter on procedures and recursion (patterns are universal)
- **`leave` instruction:** Intel® 64 and IA-32 Architectures Software Developer's Manual, Volume 2 (leave = mov rsp, rbp; pop rbp) — same as Linux; instruction is platform-independent
- **Tail call optimization:** Compiler optimization literature (manual tail-call elimination)

## Exercises

24 drills under `exercises/`. Solutions mirror the names in `solutions/`. Build line is in each file header.

Frames and spills: `01-locals-three.asm`, `05-save-r12.asm`, `12-nested-frame.asm`, `17-closure-sim.asm`. Recursion: `03-rec-sum.asm`, `04-tree-sum-flat.asm`, `06-ack-lite.asm`, `08-from-scratch-rec-pow.asm`, `10-gcd-proc.asm`, `15-rec-strlen.asm`, `16-debug-missing-pop.asm`, `21-rec-binary-digits.asm`, `23-stretch-memo-fib-slot.asm`, `24-from-scratch-rec-sum-array.asm`. Mutual `jmp`: `02-mutual-even-odd.asm`, `14-mutual-parity-count.asm`. Loop instead of a stack: `07-tail-ish-loop.asm`, `09-fib-iter-proc.asm`. Also `11-map-array-proc.asm`, `13-variadic-max.asm`, `19-compare-procs.asm`, `20-fold-list.asm`, `22-stretch-quicksort-partition.asm`.

Build with:
```bash
nasm -f elf64 FILE -o /tmp/o.o && ld /tmp/o.o -o /tmp/p && /tmp/p; echo $?
```
