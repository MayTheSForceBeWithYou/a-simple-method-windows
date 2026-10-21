; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov al, 01h
    ror al, 1
    movzx rcx, al
    mov rax,60
    call ExitProcess
main ENDP
END
