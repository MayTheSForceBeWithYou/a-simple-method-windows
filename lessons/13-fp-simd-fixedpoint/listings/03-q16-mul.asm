; 03-q16-mul.asm: Multiply Q16.16 values (2.0 * 3.0 = 6.0)
; Exit 6
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub     rsp, 32
    mov eax, 2
    shl eax, 16
    mov ebx, 3
    shl ebx, 16
    movsxd rax, eax
    movsxd rbx, ebx
    imul rax, rbx
    shr rax, 16
    shr rax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
