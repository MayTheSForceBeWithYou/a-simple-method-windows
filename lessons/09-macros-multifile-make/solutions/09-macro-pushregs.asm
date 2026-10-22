; Exercise: 09-macro-pushregs
;
; MACRO PUSH_CALLEE / POP_CALLEE for rbx r12; exit 5.
; Expected exit: 5
;
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
