; Exercise 15: lerp fixed
;
; lerp(0,10,0.5) ~5 with Q16 t=1<<15; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_15_lerp_fixed PROC
    sub rsp, 40
    mov eax, 0
    mov ebx, 10
    shl ebx, 16
    mov ecx, 1
    shl ecx, 15
    movsxd rax, ebx
    movsxd rdx, ecx
    imul rax, rdx
    shr rax, 16
    shr rax, 16
        mov     eax, ecx
    add     rsp, 40
    ret
ex_15_lerp_fixed ENDP
main PROC
    sub     rsp, 40
    call    ex_15_lerp_fixed
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
