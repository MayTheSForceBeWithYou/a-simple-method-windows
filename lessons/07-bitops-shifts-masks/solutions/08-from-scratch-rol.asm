; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov al, 0x80
    rol al, 1
    movzx rcx, al
    call ExitProcess
main ENDP
END
