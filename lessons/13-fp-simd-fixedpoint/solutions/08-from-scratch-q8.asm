; Exercise 08: from scratch q8
;
; FROM SCRATCH: Q8.8 1.5*2 exit integer 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov eax, (1 SHL 8)+(1 SHL 7)
    mov ebx, 2 SHL 8
    imul eax, ebx
    shr eax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
