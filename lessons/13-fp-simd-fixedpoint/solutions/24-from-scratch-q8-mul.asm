; Exercise 24: from scratch q8 mul
;
; FROM SCRATCH: Q8.8 2.5 * 2 = 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov eax, (2 SHL 8)+(1 SHL 7)
    mov ebx, 2 SHL 8
    imul eax, ebx
    shr eax, 8
    mov ecx, eax
    call ExitProcess
main ENDP
END
