; Expected exit: 150

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov eax, 200
    mov ebx, 100
    mov ecx, eax
    and ecx, ebx
    xor eax, ebx
    shr eax, 1
    add eax, ecx
    mov edi, eax
    mov rax,60
    call ExitProcess
main ENDP
END
