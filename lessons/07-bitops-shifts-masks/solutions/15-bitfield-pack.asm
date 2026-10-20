; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 5
    and rax, 7
    mov rbx, 2
    and rbx, 7
    shl rbx, 3
    or rax, rbx
    mov rbx, 1
    and rbx, 3
    shl rbx, 6
    or rax, rbx
    mov rcx, rax
    mov rax,60
    call ExitProcess
main ENDP
END
