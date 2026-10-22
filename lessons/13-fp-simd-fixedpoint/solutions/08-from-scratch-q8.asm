; Exercise 08: from scratch q8
;
; FROM SCRATCH: Q8.8 1.5*2 exit integer 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
ex_08_from_scratch_q8 PROC
    sub rsp, 40
    mov eax, (1 SHL 8)+(1 SHL 7)
    mov ebx, 2 SHL 8
    imul eax, ebx
    shr eax, 16
    mov ecx, eax
    mov     eax, eax
    add     rsp, 40
    ret
ex_08_from_scratch_q8 ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_q8
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
