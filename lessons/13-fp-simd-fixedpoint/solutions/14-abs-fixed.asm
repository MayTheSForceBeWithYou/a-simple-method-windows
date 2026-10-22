; Exercise 14: abs fixed
; Absolute value of Q16.16 -3.0; exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
ex_14_abs_fixed PROC
    sub rsp, 40
    mov eax, 3
    shl eax, 16
    neg eax
    test eax, eax
    jns abs_done
    neg eax
abs_done:
    sar eax, 16
    mov     eax, eax
    add rsp, 40
    ret
ex_14_abs_fixed ENDP
main PROC
    sub     rsp, 40
    call    ex_14_abs_fixed
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
