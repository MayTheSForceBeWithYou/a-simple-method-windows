# Lesson 04 — Stack & Microsoft x64 Calling Convention

The stack is a discipline. `rsp` tracks the top. `push`/`pop` save values. `call`/`ret` store the return address. The Microsoft x64 ABI says which registers hold arguments, which side saves which registers, that the caller allocates 32-byte shadow space, and that RSP is 16-byte aligned at each `call`. Get this wrong and Win32 APIs crash or silently corrupt data.

## What this lesson asks of you

Use `push`/`pop`. Write leaf and non-leaf procedures. Pass the first four integer arguments in RCX, RDX, R8, R9. Put argument 5+ at `[rsp+32]` and beyond. Allocate 32-byte shadow space before every `call`. Preserve nonvolatile registers, including **RSI and RDI** (nonvolatile on Windows, volatile on Linux). Emit unwind info with `PROC FRAME` / `.pushreg` / `.allocstack` / `.endprolog` when you save registers or allocate a frame.

Windows has **no red zone**. Do not store below RSP.

## The stack grows downward

`rsp` points at the lowest in-use address. `push rax` is `sub rsp, 8` then `mov [rsp], rax`. `pop rbx` is `mov rbx, [rsp]` then `add rsp, 8`. LIFO: unmatched push/pop corrupts RSP.

`call` pushes the next RIP then jumps. `ret` pops into RIP.

```asm
; Listing 01: PUSH and POP basics
;
; Purpose: Demonstrate stack operations with PUSH/POP.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo01-push-pop.obj 01-push-pop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-push-pop.exe 01-push-pop.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    mov rax, 42
    push rax                   ; Save RAX on stack (RSP -= 8)
    
    mov rax, 99                ; Overwrite RAX
    
    pop rbx                    ; Restore original value to RBX (RSP += 8)
                               ; RBX = 42
    
    mov rcx, rbx
    call ExitProcess
main ENDP

END
```

`push` after `sub rsp, 40` moves RSP by 8; `pop` restores it before `call ExitProcess`.

## Shadow space and argument registers

Caller allocates **32 bytes** before every `call`. Those slots are for the callee to home RCX, RDX, R8, R9. Argument 5 is `[rsp+32]` **in addition** to that 32 bytes.

| Arg | Location |
|-----|----------|
| 1 | RCX |
| 2 | RDX |
| 3 | R8 |
| 4 | R9 |
| 5+ | `[rsp+32]`, `[rsp+40]`, … |

Return value: RAX.

There is no six-argument listing on this branch. The pattern is: allocate 32 + 8×(extra args), rounded so RSP is 16-byte aligned at `call`, store extras at `[rsp+32]` onward, then `call`.

```asm
; Listing 02: MS x64 calling convention - argument passing
;
; Purpose: Demonstrate MS x64 ABI argument registers (RCX, RDX, R8, R9).
; Expected exit code: 10
; Expected output: (none)
;
; Note: MS x64 differs from System V AMD64:
; - Args: RCX, RDX, R8, R9 (not RDI, RSI, RDX, RCX)
; - Requires 32-byte shadow space on stack
; - Caller allocates shadow space; callee can use it
;
; Build: ml64 /c /Fo02-ms-x64-args.obj 02-ms-x64-args.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-ms-x64-args.exe 02-ms-x64-args.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; Function: add_four(a, b, c, d) -> a + b + c + d
; MS x64 ABI: RCX=a, RDX=b, R8=c, R9=d
add_four PROC
    mov rax, rcx               ; RAX = a
    add rax, rdx               ; RAX += b
    add rax, r8                ; RAX += c
    add rax, r9                ; RAX += d
    ret
add_four ENDP

main PROC
    sub rsp, 40                ; Shadow space
    
    ; Call add_four(1, 2, 3, 4)
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    call add_four              ; RAX = 10
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`add_four` is a leaf: no shadow allocation of its own. `main` allocates 32 for the calls it makes.

## Leaf procedures

A leaf calls nobody. It needs no shadow space for itself. It must still save nonvolatiles it uses.

```asm
; Listing 03: Leaf procedure (calls no one)
;
; Purpose: Demonstrate simple leaf function in MS x64 ABI.
; Expected exit code: 25
; Expected output: (none)
;
; Build: ml64 /c /Fo03-leaf-procedure.obj 03-leaf-procedure.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-leaf-procedure.exe 03-leaf-procedure.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; Function: square(x) -> x * x
; Leaf function: no prologue needed, just compute and return
square PROC
    imul rcx, rcx              ; RCX = RCX * RCX
    mov rax, rcx               ; Return value in RAX
    ret
square ENDP

main PROC
    sub rsp, 40
    
    mov rcx, 5
    call square                ; RAX = 25
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

5×5 = 25. `imul rcx, rcx` clobbers the argument register; that is legal (RCX is volatile).

## Volatile vs nonvolatile

| Category | Registers | Who saves |
|----------|-----------|-----------|
| Volatile | RAX, RCX, RDX, R8–R11, XMM0–XMM5 | Caller |
| Nonvolatile | RBX, RBP, **RDI, RSI**, R12–R15, XMM6–XMM15 | Callee |

```asm
; Listing 04: Preserving nonvolatile registers
;
; Purpose: Demonstrate saving/restoring RBX (nonvolatile in MS x64).
; Expected exit code: 42
; Expected output: (none)
;
; MS x64 nonvolatile registers: RBX, RBP, RDI, RSI, RSP, R12-R15, XMM6-15
; Callee must preserve these if used.
;
; Build: ml64 /c /Fo04-nonvolatile-regs.obj 04-nonvolatile-regs.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-nonvolatile-regs.exe 04-nonvolatile-regs.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; Function: uses RBX, must save/restore it
compute PROC FRAME
    push rbx                   ; Save nonvolatile RBX
    .pushreg rbx
    sub rsp, 32                ; Shadow space
    .allocstack 32
    .endprolog
    
    mov rbx, rcx               ; Use RBX
    add rbx, 10
    mov rax, rbx               ; Return result
    
    add rsp, 32
    pop rbx                    ; Restore RBX
    ret
compute ENDP

main PROC
    sub rsp, 40
    push rbx
    mov rbx, 99
    mov rcx, 32
    call compute
    cmp rbx, 99
    jne rbx_clobbered
    mov rcx, rax
    jmp exit_main
rbx_clobbered:
    mov rcx, 1
exit_main:
    pop rbx
    call ExitProcess
main ENDP

END
```

32+10=42 in RAX. `main` now saves its own RBX, sets it to 99, and after `call compute` compares it to 99. If `compute` restored RBX, ECX becomes RAX (42). If not, the `rbx_clobbered` path exits **1**. `PROC FRAME` plus `.pushreg` / `.allocstack` / `.endprolog` is unwind info: no extra instructions, only metadata.

The extra `push rbx` after `sub rsp, 40` leaves RSP ≡ 8 at `call compute` — misaligned. Quote the file as written; do not copy that prologue as the alignment model. The aligned 0-push frame is `sub rsp, 40` with no extra push (listing `05-stack-alignment`).

## Alignment

At `call`, RSP should be 16-byte aligned (0 mod 16). After `call`, the callee sees 8 mod 16. A non-leaf subtracts an odd multiple of 8 (often 40 = 32 shadow + 8) to restore 0 mod 16.

```asm
; Listing 05: Stack alignment (16-byte boundary)
;
; Purpose: Demonstrate maintaining 16-byte stack alignment.
; Expected exit code: 15
; Expected output: (none)
;
; MS x64 requires RSP to be 16-byte aligned before CALL.
; After CALL, the return address makes it misaligned (RSP+8).
; Functions must account for this.
;
; Build: ml64 /c /Fo05-stack-alignment.obj 05-stack-alignment.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-stack-alignment.exe 05-stack-alignment.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_three PROC FRAME
    ; On entry: RSP is 8 mod 16 (return address pushed)
    ; We need 32 bytes shadow + maintain alignment
    sub rsp, 40                ; 40 bytes keeps 16-byte alignment
    .allocstack 40
    .endprolog
    
    mov rax, rcx
    add rax, rdx
    add rax, r8
    
    add rsp, 40
    ret
sum_three ENDP

main PROC
    sub rsp, 40                ; 40 to maintain alignment (8 + 32 + alignment)
    
    mov rcx, 5
    mov rdx, 4
    mov r8, 6
    call sum_three             ; RAX = 15
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

`sum_three` does not actually `call` anyone; the 40-byte frame is the alignment pattern for a non-leaf. 5+4+6=15.

## Worked example: `sum3`

```asm
; Listing 06: sum3 worked example from LESSON.md (MS x64)
;
; Purpose: Sum three numbers using function (lines 162-183 of LESSON.md).
; Expected exit code: 60
; Expected output: (none)
;
; Build: ml64 /c /Fo06-sum3-example.obj 06-sum3-example.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-sum3-example.exe 06-sum3-example.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; sum3(a, b, c) -> a+b+c
; MS x64: RCX=a, RDX=b, R8=c
sum3 PROC
    mov rax, rcx               ; RAX = a
    add rax, rdx               ; RAX = a + b
    add rax, r8                ; RAX = a + b + c
    ret
sum3 ENDP

main PROC
    sub rsp, 40
    
    mov rcx, 10
    mov rdx, 20
    mov r8, 30
    call sum3                  ; RAX = 60
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Immediately before `call sum3`: RCX=10, RDX=20, R8=30. `main` allocated **40** bytes (32 of shadow plus 8 so RSP is 0 mod 16 at the `call`). `sum3` is a leaf; it does not touch the shadow space. RAX=60. Exit 60.

### A plausible wrong reading (and why it fails)

*"Four register arguments exist, so I can `call` with RSP unaligned and with no shadow space, like a Linux leaf using the red zone."*

**Why it fails:** Windows has no red zone. On callee entry the return address is at `[rsp]`. The 32-byte shadow sits **above** that return address, at `[rsp+8, rsp+40)` — the caller allocated it before `call`. It is not the memory below the incoming RSP. Callees home RCX/RDX/R8/R9 there and assume 16-byte alignment for XMM spills. With entry RSP ≡ 8 (mod 16), `sub rsp, 32` would leave RSP ≡ 8 at `call`. Listing `06-sum3-example` and listing `05-stack-alignment` both use `sub rsp, 40` so RSP is 0 mod 16 at the `call`. Integer-only `sum3` may still run with a 32-byte frame; SSE-using callees may not.

## Frame pointer

```asm
; Listing 07: RBP frame forms (LESSON.md)
;
; Purpose: Two Win64 unwind patterns — .SETFRAME vs .PUSHREG-only RBP.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo07-frame-pointer.obj 07-frame-pointer.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-frame-pointer.exe 07-frame-pointer.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; Form 1: RBP is a real frame pointer for unwind (locals below [rbp-8]…).
; .SETFRAME offset N must equal the stack allocation and match lea rbp,[rsp+N].
compute_setframe PROC FRAME
    push rbp
    .pushreg rbp
    sub rsp, 48
    lea rbp, [rsp+48]          ; N = 48 (multiple of 16, <= 240)
    .setframe rbp, 48
    .allocstack 48
    .endprolog

    mov rax, 42

    add rsp, 48
    pop rbp
    ret
compute_setframe ENDP

; Form 2: RBP is just another saved nonvolatile (no .SETFRAME).
compute_rbp_saved PROC FRAME
    push rbp
    .pushreg rbp
    sub rsp, 40
    .allocstack 40
    .endprolog

    mov rbp, 42                ; use RBP as a general preserved slot
    mov rax, rbp

    add rsp, 40
    pop rbp
    ret
compute_rbp_saved ENDP

main PROC
    sub rsp, 40
    call compute_setframe
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

Listing `07-frame-pointer` is two procedures in one file. Form 1 (`compute_setframe`) is a real frame pointer: `push rbp`, `sub rsp, 48`, `lea rbp, [rsp+48]`, `.setframe rbp, 48`, `.allocstack 48`. The `.SETFRAME` offset must be a **multiple of 16 and at most 240**. It does **not** have to equal the stack allocation. This listing happens to use 48 for both `lea`/`setframe` and `.allocstack`. `main` calls form 1 and exits **42**. Form 2 (`compute_rbp_saved`) is in the same file: RBP is only a saved nonvolatile (`push rbp` / `.pushreg rbp` / `sub rsp, 40`, no `.setframe`). Listing `08-rbp-pushreg-only` is that second form as its own program (`sub rsp, 32` in that file).

```asm
; Listing 08: RBP saved as nonvolatile only (no .SETFRAME)
;
; Purpose: Contrast with listing 07 form 1 — unwind sees RBP as pushed, not a frame base.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo08-rbp-pushreg-only.obj 08-rbp-pushreg-only.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-rbp-pushreg-only.exe 08-rbp-pushreg-only.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

compute_rbp_saved PROC FRAME
    push rbp
    .pushreg rbp
    sub rsp, 32
    .allocstack 32
    .endprolog

    mov rbp, 42
    mov rax, rbp

    add rsp, 32
    pop rbp
    ret
compute_rbp_saved ENDP

main PROC
    sub rsp, 40
    call compute_rbp_saved
    mov rcx, rax
    call ExitProcess
main ENDP

END
```

After a form-1 prologue, locals are `[rbp-8]`, `[rbp-16]`, … independent of further RSP motion. Form 1 never stores a local; it returns 42. Form 2 writes 42 into RBP as a preserved slot and copies it to RAX.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| Linux 6 register args | Windows 4: RCX, RDX, R8, R9. |
| Red zone | None on Windows. |
| RSI/RDI | Nonvolatile here; volatile on Linux. |
| Shadow vs arg 5 | On the caller, arg 5 is `[rsp+32]` above the 32-byte home area. On callee entry the return address is at `[rsp]`; shadow is `[rsp+8, rsp+40)`. |
| Shadow is below incoming RSP | No. Shadow is **above** the return address. Memory below incoming RSP is unused (no red zone). |
| `PROC` vs `PROC FRAME` | FRAME emits unwind metadata. |
| 32 vs 40 | 32 is shadow size; 40 is a common shadow+alignment total after the return address. |

## Check yourself

1. `foo(a,b,c,d,e)`: which register or slot is `e`?
2. You use RSI in a returning procedure. What must the prologue/epilogue do?
3. In listing `04-nonvolatile-regs`, what is RBX in `main` after `call compute`?
4. Why does listing `05-stack-alignment` use `sub rsp, 40` inside `sum_three`?
5. What does `.endprolog` assemble to?

## Key takeaways

- Stack grows down. `call` pushes RIP; `ret` pops it.
- RCX, RDX, R8, R9 then `[rsp+32]`. Return in RAX. 32-byte shadow is mandatory.
- RSI/RDI/RBX/RBP/R12–R15 are callee-saved.
- `PROC FRAME` + `.pushreg` / `.allocstack` / `.endprolog` is unwind info.
- No red zone.

## Lookup (reference only, not curriculum)

- https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention
- https://learn.microsoft.com/en-us/cpp/build/exception-handling-x64
- https://learn.microsoft.com/en-us/cpp/build/stack-usage

## Exercises

Quoted listings: `01-push-pop.asm` through `08-rbp-pushreg-only.asm`.
