; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 0ABCDh
    shr rax, 4
    and rax, 0Fh
    mov rcx, rax
    call ExitProcess
main ENDP
END
