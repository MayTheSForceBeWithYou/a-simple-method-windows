; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov al, 80h
    rol al, 1
    movzx rcx, al
    call ExitProcess
main ENDP
END
