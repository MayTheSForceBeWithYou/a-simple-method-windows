; Expected exit: 2

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 0b01010101
    shr rax, 3
    and rax, 7
    mov rcx, rax
    mov rax,60
    call ExitProcess
main ENDP
END
