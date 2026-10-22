; Exercise 13: neg fixed
; Negate Q16.16 value -2.0; exit 2 (integer part of +2.0).
; Expected exit: 2

EXTERN ExitProcess:PROC

.code
ex_13_neg_fixed PROC
    sub rsp, 40
    mov eax, 2
    shl eax, 16
    neg eax                 ; -2.0 Q16.16
    neg eax                 ; negate -> +2.0
    sar eax, 16
    mov     eax, eax
    add rsp, 40
    ret
ex_13_neg_fixed ENDP
main PROC
    sub     rsp, 40
    call    ex_13_neg_fixed
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
