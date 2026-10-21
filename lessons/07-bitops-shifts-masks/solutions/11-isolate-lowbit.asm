; Expected exit: 4

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 101100b
    mov rbx, rax
    neg rbx
    and rax, rbx
    mov rcx, rax
    mov rax,60
    call ExitProcess
main ENDP
END
