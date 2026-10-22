; Exercise: 02-fixed-add
;
; 1.5 + 2.5 in Q16.16; exit 4.
; Expected exit: 4
;
.code
ex_02_fixed_add PROC
    sub rsp, 40
    mov eax, (1 SHL 16)+(1 SHL 15)
    mov ebx, (2 SHL 16)+(1 SHL 15)
    add eax, ebx
    shr eax, 16
    mov ecx, eax
    mov     eax, eax
    add     rsp, 40
    ret
ex_02_fixed_add ENDP
main PROC
    sub     rsp, 40
    call    ex_02_fixed_add
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
