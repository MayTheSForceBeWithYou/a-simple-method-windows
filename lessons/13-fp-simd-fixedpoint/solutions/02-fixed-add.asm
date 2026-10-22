; Exercise 02: fixed add
;
; 1.5 + 2.5 in Q16.16; exit 4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.code
ex_02_fixed_add PROC
    sub rsp, 40
    mov eax, (1 SHL 16)+(1 SHL 15)
    mov ebx, (2 SHL 16)+(1 SHL 15)
    add eax, ebx
    shr eax, 16
        mov     eax, eax
    ret

ex_02_fixed_add ENDP
main PROC
    call    ex_02_fixed_add
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
