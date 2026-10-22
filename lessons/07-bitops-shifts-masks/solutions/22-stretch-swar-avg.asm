; Expected exit: 150

EXTERN ExitProcess:PROC

.code

ex_22_stretch_swar_avg PROC
mov eax, 200
    mov ebx, 100
    mov ecx, eax
    and ecx, ebx
    xor eax, ebx
    shr eax, 1
    add eax, ecx
    movzx rcx, ax

    ret
ex_22_stretch_swar_avg ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_swar_avg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
