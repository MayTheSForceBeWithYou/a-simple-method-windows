; Exercise 10: q16 frac
;
; 0.5 in Q16.16 is 1<<15; add two -> 1.0; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov eax, 1
    shl eax, 15
    add eax, eax
    shr eax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
