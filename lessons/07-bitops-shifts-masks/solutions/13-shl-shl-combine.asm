; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 0Ah
    shl rax, 4
    or rax, 0Bh
    mov rcx, rax
    mov rax,60
    call ExitProcess
main ENDP
END
