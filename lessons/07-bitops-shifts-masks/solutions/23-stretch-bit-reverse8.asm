; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    movzx eax, byte [v]
    xor ebx, ebx
    mov ecx, 8
.l:
    shl ebx, 1
    mov edx, eax
    and edx, 1
    or ebx, edx
    shr eax, 1
    loop .l
    mov edi, ebx
    mov rax,60
    call ExitProcess
main ENDP
END
