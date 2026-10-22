; Exercise: 07-idiv-setup
;
; Divide 84 by 2 using idiv. cqo; idiv. Exit with quotient in rcx.
; Expected exit: 42
;
.code
ex_07_idiv_setup PROC
    sub rsp, 40
    mov rax, 84
    cqo
    mov rbx, 2
    idiv rbx
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_07_idiv_setup ENDP
main PROC
    sub     rsp, 40
    call    ex_07_idiv_setup
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
