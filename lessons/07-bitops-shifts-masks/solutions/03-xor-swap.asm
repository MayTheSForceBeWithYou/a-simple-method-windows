; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 1
    mov rbx, 2
    xor rax, rbx
    xor rbx, rax
    xor rax, rbx
    mov rcx, rax
    call ExitProcess
main ENDP
END
