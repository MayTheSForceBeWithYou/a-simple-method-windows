; Exercise 09: macro pushregs
;
; MACRO PUSH_CALLEE / POP_CALLEE for rbx r12; exit 5.
;
; Build: ml64 /c 09-macro-pushregs.asm && link /OUT:09-macro-pushregs.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-macro-pushregs.obj kernel32.lib
;
; Expected exit: 5

EXTERN ExitProcess:PROC

; MASM macros for saving/restoring callee-saved registers
PUSH_CALLEE MACRO
    push rbx
    push r12
ENDM

POP_CALLEE MACRO
    pop r12
    pop rbx
ENDM

.code
ex_09_macro_pushregs PROC
    sub rsp, 40
    
    mov rbx, 5
    PUSH_CALLEE
    mov rbx, 0
    POP_CALLEE
    
    mov rcx, rbx
    mov     eax, ebx
    add     rsp, 40
    ret
ex_09_macro_pushregs ENDP
main PROC
    sub     rsp, 40
    call    ex_09_macro_pushregs
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
