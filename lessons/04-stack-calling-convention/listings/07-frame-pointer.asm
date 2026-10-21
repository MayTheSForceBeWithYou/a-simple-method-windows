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
    sub rsp, 40
    lea rbp, [rsp+40]          ; N = 40 (multiple of 16, <= 240)
    .setframe rbp, 40
    .allocstack 40
    .endprolog

    mov rax, 42

    add rsp, 40
    pop rbp
    ret
compute_setframe ENDP

; Form 2: RBP is just another saved nonvolatile (no .SETFRAME).
compute_rbp_saved PROC FRAME
    push rbp
    .pushreg rbp
    sub rsp, 32
    .allocstack 32
    .endprolog

    mov rbp, 42                ; use RBP as a general preserved slot
    mov rax, rbp

    add rsp, 32
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
