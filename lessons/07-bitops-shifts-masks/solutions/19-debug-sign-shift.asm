; Expected exit: 252

EXTERN ExitProcess:PROC

.code

ex_19_debug_sign_shift PROC
mov rax, -16
    sar rax, 2
    movzx rcx, al
    mov rax,60
    ; return value already in EAX/RAX
    ret
ex_19_debug_sign_shift ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_sign_shift
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
