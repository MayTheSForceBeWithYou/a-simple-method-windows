; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, -16
    sar rax, 2
    movzx rcx, al
    mov rax,60
    call ExitProcess
main ENDP
END
