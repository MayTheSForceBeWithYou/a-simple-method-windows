; Expected exit: 31

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 1
    shl rax, 5
    dec rax
    mov rcx, rax
    mov rax,60
    call ExitProcess
main ENDP
END
