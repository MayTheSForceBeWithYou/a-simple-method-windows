; Expected exit: 12

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 0ABCDh
    shr rax, 4
    and rax, 0Fh
    mov rcx, rax
    call ExitProcess
main ENDP
END
