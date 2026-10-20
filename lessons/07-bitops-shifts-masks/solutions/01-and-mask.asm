; Expected exit: 15

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 0xFF
    and rax, 0x0F
    mov rcx, rax
    call ExitProcess
main ENDP
END
