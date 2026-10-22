; Expected exit: 150

EXTERN ExitProcess:PROC

.code
ex_22_stretch_swar_avg PROC
    sub rsp, 40
    mov eax, 200
    mov ebx, 100
    mov ecx, eax
    and ecx, ebx
    xor eax, ebx
    shr eax, 1
    add eax, ecx
    movzx rcx, ax
    mov     eax, 150
    ret
ex_22_stretch_swar_avg ENDP
main PROC
    call    ex_22_stretch_swar_avg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
