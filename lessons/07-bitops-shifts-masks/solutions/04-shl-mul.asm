; Expected exit: 24

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 3
    shl rax, 3
    mov rcx, rax
    call ExitProcess
main ENDP
END
