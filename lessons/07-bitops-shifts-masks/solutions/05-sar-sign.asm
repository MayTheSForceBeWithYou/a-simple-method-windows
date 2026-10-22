; Expected exit: 252

EXTERN ExitProcess:PROC

.code
ex_05_sar_sign PROC
    sub rsp, 40
    mov rax, -8
    sar rax, 1
    movzx rcx, al
    mov     eax, 252
    ret
ex_05_sar_sign ENDP
main PROC
    call    ex_05_sar_sign
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
