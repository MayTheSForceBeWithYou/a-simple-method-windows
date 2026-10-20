# Lesson 04 — Stack & Microsoft x64 Calling Convention

The stack is a discipline, not just a data structure. This lesson teaches you how `rsp` tracks the stack pointer, how `push` and `pop` manipulate it, and why the stack is where function calls store return addresses, arguments, and local variables. You will learn the Microsoft x64 ABI (Application Binary Interface) for Windows user-space function calls: which registers hold arguments, which registers the caller must save, which the callee must save, and why 16-byte alignment and 32-byte shadow space matter. By mastering this convention, you can write functions that call other functions, pass arguments correctly, and interoperate with Win32 APIs.

## What this lesson asks of you

You must be able to use `push` and `pop` to save and restore registers, and understand that the stack grows downward (toward lower addresses) with `rsp` pointing to the top. You will implement leaf procedures (functions that call no one) and non-leaf procedures (functions that call others) with correct prologues and epilogues, allocating stack space for shadow space, local variables, and saved registers. You will pass the first four integer/pointer arguments in `rcx`, `rdx`, `r8`, `r9`, and additional arguments on the stack above the shadow space. You will respect 16-byte stack alignment before every `call` and allocate 32 bytes of shadow space, or your program will crash or corrupt data. Finally, you will distinguish caller-saved (volatile) registers from callee-saved (nonvolatile) registers, noting that **RSI and RDI are nonvolatile on Windows** (the opposite of Linux).

## The stack: growing downward from high memory

The **stack** is a region of memory used for temporary storage. On x86-64 Linux, the stack starts at a high address (near the top of the virtual address space) and **grows downward** toward lower addresses. The `rsp` register (stack pointer) always points to the **top** of the stack (the lowest address currently in use).

Pushing a value onto the stack moves `rsp` down (decrements it) and stores the value at the new location. Popping a value moves `rsp` up (increments it) and reads the value from the old location.

### `push` and `pop`

```asm
push rax              ; rsp -= 8; [rsp] = rax
pop rbx               ; rbx = [rsp]; rsp += 8
```

Concretely, `push rax` is equivalent to:
```asm
sub rsp, 8
mov [rsp], rax
```

And `pop rbx` is equivalent to:
```asm
mov rbx, [rsp]
add rsp, 8
```

The stack stores quadwords (8 bytes) at a time for 64-bit values. If you push `rax` (8 bytes), `rsp` decrements by 8. If you later pop into `rbx`, `rsp` increments by 8 and you recover the value.

The stack is LIFO (last in, first out). If you push A, then push B, you must pop B before you can pop A. Forgetting to balance pushes and pops corrupts `rsp` and causes crashes.

### `call` and `ret`

The `call` instruction pushes the address of the next instruction (the return address) onto the stack, then jumps to the target address. The `ret` instruction pops the return address from the stack and jumps to it. This is how function calls work:

```asm
call myfunc           ; push return address; jmp myfunc
; ... when myfunc finishes, it executes ret:
ret                   ; pop return address into rip
```

If you call a function and it does not `ret`, or if you corrupt `rsp` so `ret` pops the wrong value, your program jumps to a garbage address and crashes.

### Shadow space (Microsoft x64 ABI requirement)

The Microsoft x64 ABI requires the **caller** to allocate **32 bytes** (4 × 8-byte slots) of "shadow space" (also called "home space") on the stack before every `call`, even if the function has fewer than four arguments or no arguments at all. This space is reserved for the callee to spill the register arguments `rcx`, `rdx`, `r8`, `r9` into memory if needed (though modern optimized code rarely does this). The shadow space slots are at `[rsp]`, `[rsp+8]`, `[rsp+16]`, and `[rsp+24]` immediately before the `call` (after the `call` pushes the return address, they are at `[rsp+8]` through `[rsp+32]` inside the callee).

Omitting shadow space violates the ABI and can corrupt the stack. Even leaf functions (functions that call no one) do not need shadow space *for themselves*, but if they call anyone, they must allocate it. For non-leaf functions, allocate shadow space plus any local variables and alignment padding in the prologue with a single `sub rsp, N`.

## Microsoft x64 calling convention

When you call a function (or when a function you write is called), both sides must agree on how arguments are passed, which registers hold the return value, and which registers each side is responsible for preserving. The Microsoft x64 ABI is the standard for Windows user-space function calls.

### Argument passing

| Argument | Location |
|----------|----------|
| 1st | `rcx` |
| 2nd | `rdx` |
| 3rd | `r8` |
| 4th | `r9` |
| 5th and beyond | Stack, at `[rsp+32]`, `[rsp+40]`, etc. (after shadow space) |

**Critical:** Only the first **four** integer/pointer arguments go in registers. The fifth and subsequent arguments go on the stack **above** the 32-byte shadow space.

For example, calling `foo(a, b, c, d, e, f)` with six arguments looks like:

<!-- LISTING-PENDING: lessons/04-stack-calling-convention/listings/call-six-args.asm -->

```asm
sub rsp, 48           ; 32 bytes shadow + 16 bytes for args 5 & 6 (aligned)
mov rcx, a_value      ; 1st argument
mov rdx, b_value      ; 2nd argument
mov r8, c_value       ; 3rd argument
mov r9, d_value       ; 4th argument
mov QWORD PTR [rsp+32], e_value   ; 5th argument (first stack slot after shadow)
mov QWORD PTR [rsp+40], f_value   ; 6th argument
call foo
add rsp, 48           ; deallocate stack space after call
```

**Note:** The stack must remain 16-byte aligned before the `call` instruction. Since `call` pushes 8 bytes (the return address), we allocate a total that leaves RSP aligned. Here, 48 = 32 (shadow) + 16 (two arguments, rounded to multiple of 16).

### Return value

The return value is placed in `rax`. For 128-bit returns (rare), the high 64 bits go in `rdx` and the low 64 bits in `rax`.

### Caller-saved (volatile) vs callee-saved (nonvolatile) registers

Registers fall into two categories:

| Category | Registers | Responsibility |
|----------|-----------|----------------|
| **Caller-saved (volatile)** | `rax`, `rcx`, `rdx`, `r8`–`r11` | The **caller** must save these before calling another function if it needs their values afterward. The callee may clobber them freely. |
| **Callee-saved (nonvolatile)** | `rbx`, `rbp`, `rdi`, `rsi`, `r12`–`r15` | The **callee** must save these if it uses them, and restore them before returning. The caller can assume they are unchanged. |

**Critical difference from Linux:** On Windows, **RSI and RDI are nonvolatile** (callee-saved). On Linux (System V), RSI and RDI are volatile (caller-saved) because they hold the first two arguments. This is a fundamental ABI difference.

For example, if you are writing a function and you need to use `rbx`, `rsi`, or `rdi`, you must `push` them at the start and `pop` them before returning. If you use `rax`, `rcx`, or `rdx`, you do not need to save them (they are caller-saved and the caller is responsible).

If you are writing code that calls a function, you must save `rdi`, `rsi`, `rdx`, `rcx`, `r8`–`r11` before the call if you need them afterward, because the called function may overwrite them.

### Stack alignment

Before executing a `call` instruction, `rsp` must be aligned to **16 bytes**. Specifically, `rsp ≡ 8 (mod 16)` at the point of `call`, because `call` pushes an 8-byte return address, making `rsp ≡ 0 (mod 16)` inside the called function. Many Win32 API functions and library functions (especially those using SSE/AVX) require 16-byte alignment and will crash or misbehave if the stack is misaligned.

**Combining shadow space and alignment:** You need 32 bytes of shadow space, plus any stack arguments, plus any local variables. The total allocation must be a multiple of 16, and must leave RSP aligned to 16 at entry (before the prologue). The common pattern is to allocate 32 + N where N is adjusted to make the total a multiple of 16.

For example:
- 32 bytes shadow space only: allocate 40 (32 + 8 for alignment).
- 32 bytes shadow + 16 bytes locals: allocate 48 (32 + 16 = 48, already a multiple of 16).
- 32 bytes shadow + 1 stack argument (8 bytes): allocate 48 (32 + 16, rounding 32 + 8 up to next multiple of 16).

After `sub rsp, N`, RSP must be 16-byte aligned for the next `call`. Since `call` will push 8 bytes, the called function sees RSP aligned to 16.

## Procedure prologue and epilogue

A **prologue** sets up the stack frame (allocates space for locals, saves callee-saved registers). An **epilogue** tears it down (restores registers, deallocates space) and returns.

### With frame pointer (`rbp`)

```asm
myfunc:
    push rbp              ; save old frame pointer
    mov rbp, rsp          ; set up new frame pointer
    sub rsp, 32           ; allocate 32 bytes for locals

    ; function body (access locals as [rbp-N])

    mov rsp, rbp          ; deallocate locals
    pop rbp               ; restore old frame pointer
    ret
```

Using `rbp` as a frame pointer makes debugging easier (debuggers and stack unwinders can walk frames), but it is optional for optimization.

### Without frame pointer

```asm
myfunc:
    sub rsp, 32           ; allocate 32 bytes for locals

    ; function body (access locals as [rsp+N])

    add rsp, 32           ; deallocate locals
    ret
```

This saves two instructions but makes debugging harder. For hand-written assembly in this course, either style is fine.

### Leaf vs non-leaf functions

A **leaf function** is one that does not call any other functions. It does not need to allocate shadow space (since it makes no calls), but if it uses any nonvolatile registers (RBX, RBP, RSI, RDI, R12-R15), it must save and restore them. Windows has **no red zone** — there is no reserved space below RSP for temporary use. If you need local variables, allocate stack space explicitly with `sub rsp, N`.

A **non-leaf function** calls other functions, so it must allocate shadow space (32 bytes minimum) plus any locals and alignment padding, save any nonvolatile registers it uses, respect stack alignment, and ensure `rsp` is correct when it calls and when it returns.

## Worked example: a function that sums three numbers

Let's write a function `sum3(a, b, c)` that takes three 64-bit integers and returns their sum. Then we call it from `main` and exit with the result.

<!-- LISTING-PENDING: lessons/04-stack-calling-convention/listings/sum3.asm -->

```asm
EXTERN ExitProcess:PROC

.code

; long sum3(long a, long b, long c)
; Arguments: rcx=a, rdx=b, r8=c
; Return: rax = a+b+c
sum3 PROC
    mov rax, rcx          ; rax = a
    add rax, rdx          ; rax = a + b
    add rax, r8           ; rax = a + b + c
    ret
sum3 ENDP

main PROC
    sub rsp, 40           ; allocate shadow space (32) + alignment (8) = 40
    
    mov rcx, 10           ; first argument
    mov rdx, 20           ; second argument
    mov r8, 30            ; third argument
    call sum3             ; rax = sum3(10, 20, 30) = 60

    mov ecx, eax          ; exit status = 60 (low 32 bits)
    call ExitProcess
    ; ExitProcess does not return
main ENDP
END
```

Build and run:
```cmd
ml64 /c sum3.asm
link /OUT:sum3.exe /ENTRY:main /SUBSYSTEM:CONSOLE sum3.obj kernel32.lib
sum3.exe
echo %ERRORLEVEL%   REM prints 60
```

Trace the reasoning. The function `sum3` expects its arguments in `rcx`, `rdx`, and `r8` (the first three argument registers under MS x64 ABI). It copies `rcx` to `rax`, adds `rdx`, then adds `r8`, leaving the sum in `rax`. It does not push or pop anything because it does not use any nonvolatile (callee-saved) registers and does not call other functions (it is a leaf function). It simply returns with `ret`.

In `main`, we allocate 40 bytes of stack space: 32 bytes for shadow space (required before every call) and 8 bytes for alignment (so the total is a multiple of 16, and RSP is correctly aligned before the `call`). Then we load 10, 20, and 30 into `rcx`, `rdx`, and `r8`, and `call sum3`. The `call` instruction pushes the return address onto the stack and jumps to `sum3`. When `sum3` executes `ret`, it pops the return address and returns to the instruction after `call sum3`. At that point, `rax` holds 60. We move the low 32 bits into ECX (which zero-extends to RCX) and call `ExitProcess` with exit code 60.

### A plausible wrong reading (and why it fails)

A common mistake is to forget to allocate shadow space before a call. Suppose you write:

```asm
mov rcx, 10
mov rdx, 20
call sum3             ; WRONG: no shadow space allocated
```

This violates the Microsoft x64 ABI. The called function expects the caller to have reserved 32 bytes at `[rsp]` through `[rsp+31]` (after the `call` pushes the return address, these become `[rsp+8]` through `[rsp+39]` inside the callee). Without this space, the callee might write into your return address or other important stack data, corrupting the stack and causing a crash or silent misbehavior on return. **Always** allocate at least 32 bytes with `sub rsp, N` (where N ≥ 32 and is adjusted for alignment) before every call.

Another common mistake is to forget that RSI and RDI are **nonvolatile** on Windows. If you write a function that uses RSI or RDI, you must save them on entry and restore them before returning:

```asm
myfunc PROC
    push rsi              ; save nonvolatile register
    push rdi              ; save nonvolatile register
    sub rsp, 32           ; shadow space (adjust for alignment if needed)

    ; function body uses rsi and rdi

    add rsp, 32           ; deallocate shadow space
    pop rdi               ; restore nonvolatile registers
    pop rsi
    ret
myfunc ENDP
```

If you forget to save and restore nonvolatile registers, the caller's values are lost, and bugs appear when the caller tries to use those registers after the call.

Or move it to a callee-saved register like `rbx` (after saving `rbx` yourself).

## Distinctions worth keeping straight

| Confusion | What actually separates them |
|-----------|------------------------------|
| `push` vs `sub rsp, 8; mov [rsp], reg` | They are equivalent, but `push` is a single instruction and easier to read. Use `push` for saving registers, `sub rsp` for allocating larger blocks. |
| `call` vs `jmp` | `call` pushes the return address before jumping; `jmp` does not. Use `call` for functions that return, `jmp` for tail calls or control flow. |
| `ret` vs `pop rip` | You cannot write `pop rip` directly — `ret` is the instruction that pops the return address into `rip` and jumps to it. |
| Caller-saved (volatile) vs callee-saved (nonvolatile) | Volatile registers (`rax`, `rcx`, `rdx`, `r8`–`r11`) can be clobbered by any function you call; the caller must save them if needed. Nonvolatile registers (`rbx`, `rbp`, `rdi`, `rsi`, `r12`–`r15`) must be preserved by the callee if it uses them. **RSI and RDI are nonvolatile on Windows** (opposite of Linux). |
| MS x64 4 register args vs Linux 6 register args | Microsoft x64 uses `rcx`, `rdx`, `r8`, `r9` (4 registers); Linux System V uses `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9` (6 registers). The 5th and beyond go on the stack in both cases, but the offset differs due to shadow space on Windows. |
| Shadow space (Windows) vs red zone (Linux) | Windows requires the **caller** to allocate 32 bytes of shadow space before every call (mandatory, at `[rsp]` through `[rsp+31]` before `call`). Linux has a 128-byte red zone *below* RSP that leaf functions can use (optional, not for calls). They are opposite in direction and responsibility. |
| Stack grows down vs array indexing grows up | The stack grows toward lower addresses (pushing decrements `rsp`), but arrays grow toward higher addresses (indexing increments). If you allocate an array on the stack, the first element is at the *highest* address (closest to the original `rsp`). |
| 16-byte alignment | Before `call`, `rsp` must be `≡ 8 (mod 16)` so that after `call` pushes the return address, `rsp ≡ 0 (mod 16)`. Allocate shadow space + locals + alignment padding such that RSP is correctly aligned before the call. |
| Prologue with vs without `rbp` | Using `rbp` as a frame pointer (push `rbp`, `mov rbp, rsp`) makes debugging easier but costs two instructions. Without it, you access locals relative to `rsp`, which changes as you push/pop. Both are valid. |

## Check yourself

1. After `push rax`, where does `rsp` point? If `rsp` was `0x7fffffffe000` before the push, what is `rsp` afterward?
2. You write a function that uses `rbx`, `rsi`, and `r12`. Which of these must you save and restore, and why? (Hint: check which are nonvolatile on Windows.)
3. Trace the stack pointer through this sequence: `call myfunc` (where `myfunc` does `push rbp`, then `ret` without popping `rbp`). What goes wrong?
4. You call a Win32 API function with 6 arguments. The first 4 go in registers. Where do the 5th and 6th arguments go on the stack, relative to RSP before the call? (Remember shadow space.)
5. Why does `rsp` need to be `≡ 8 (mod 16)` just before `call`, not `≡ 0 (mod 16)`? What happens during `call` that changes the alignment?

## Key takeaways

- The stack grows downward (toward lower addresses); `rsp` points to the top (lowest address in use); `push` decrements `rsp` and stores, `pop` loads and increments `rsp`.
- The Microsoft x64 ABI passes the first four integer/pointer arguments in `rcx`, `rdx`, `r8`, `r9`; additional arguments go on the stack above 32 bytes of shadow space, and the return value goes in `rax`.
- Volatile (caller-saved) registers (`rax`, `rcx`, `rdx`, `r8`–`r11`) may be clobbered by any call; the caller must save them if needed. Nonvolatile (callee-saved) registers (`rbx`, `rbp`, `rdi`, `rsi`, `r12`–`r15`) must be preserved by the callee. **RSI and RDI are nonvolatile on Windows** (opposite of Linux).
- Before every `call`, the caller must allocate at least 32 bytes of shadow space on the stack and maintain 16-byte alignment (`rsp ≡ 8 mod 16`) before the `call` so that after `call` pushes the return address, `rsp ≡ 0 mod 16` inside the callee.
- A prologue allocates stack space (shadow space + locals + alignment), saves nonvolatile registers, and sets up the frame; an epilogue restores registers, deallocates space, and returns.
- Windows has no red zone (no reserved space below RSP); all stack space must be allocated explicitly with `sub rsp, N` before use.

## Lookup (reference only, not curriculum)

- **Microsoft x64 calling convention:** https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions (overview of argument passing, volatile/nonvolatile registers, stack alignment, shadow space)
- **Stack frame layout:** https://learn.microsoft.com/en-us/cpp/build/stack-usage (shadow space, stack allocation, alignment requirements)
- **Stack instructions:** Intel® 64 and IA-32 Architectures Software Developer's Manual, Volume 2, entries for `push`, `pop`, `call`, `ret` — same as Linux; stack instructions are platform-independent
- **MASM procedure syntax:** https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-for-x64-ml64-exe (`PROC`, `ENDP`, `END` directives)

## Exercises

28 drills: push/pop, call/ret, ABI args, callee-saved, alignment, nesteds, bug hunts.
