; Expected exit: 252

EXTERN ExitProcess:PROC

.code
ex_19_debug_sign_shift PROC
    sub rsp, 40
    mov rax, -16
    sar rax, 2
    movzx rcx, al
    call ExitProcess
    mov     eax, 60
    add     rsp, 40
    ret
ex_19_debug_sign_shift ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_sign_shift
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
