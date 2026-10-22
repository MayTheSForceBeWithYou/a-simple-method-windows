; Exercise 24: from scratch q8 mul
;
; FROM SCRATCH: Q8.8 2.5 * 2 = 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code

ex_24_from_scratch_q8_mul PROC
mov eax, (2 SHL 8)+(1 SHL 7)
    mov ebx, 2 SHL 8
    imul eax, ebx
    shr eax, 16
    mov ecx, eax
    ret
ex_24_from_scratch_q8_mul ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_q8_mul
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
