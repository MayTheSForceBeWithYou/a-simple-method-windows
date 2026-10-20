; Expected exit: 4

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 7
    mov rbx, rax
    shr rbx, 1
    xor rax, rbx
    mov rcx, rax
    mov rax,60
    call ExitProcess
main ENDP
END
