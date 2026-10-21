; Expected exit: 15

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 0FFh
    and rax, 0Fh
    mov rcx, rax
    call ExitProcess
main ENDP
END
