; Expected exit: 252

EXTERN ExitProcess:PROC

.code
ex_19_debug_sign_shift PROC
    sub rsp, 40
    mov rax, -16
    sar rax, 2
    movzx rcx, al
        mov     eax, 60
    ret

ex_19_debug_sign_shift ENDP
main PROC
    call    ex_19_debug_sign_shift
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
