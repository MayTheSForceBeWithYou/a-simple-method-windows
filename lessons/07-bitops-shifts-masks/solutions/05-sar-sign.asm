; Expected exit: 252

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, -8
    sar rax, 1
    movzx rcx, al
    call ExitProcess
main ENDP
END
