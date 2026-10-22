; Exercise 10: q16 frac
;
; 0.5 in Q16.16 is 1<<15; add two -> 1.0; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_10_q16_frac PROC
    sub rsp, 40
    mov eax, 1
    shl eax, 15
    add eax, eax
    shr eax, 16
        mov     eax, eax
    ret
    add     rsp, 40
ex_10_q16_frac ENDP
main PROC
    call    ex_10_q16_frac
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
