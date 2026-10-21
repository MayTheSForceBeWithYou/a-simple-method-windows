; Expected exit: 2

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 01010101b
    shr rax, 3
    and rax, 7
    mov rcx, rax
    mov rax,60
    call ExitProcess
main ENDP
END
