; Exercise 18: round fixed
; Round Q16.16 3.5 to 4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.code
ex_18_round_fixed PROC
    sub rsp, 40
    mov eax, 3
    shl eax, 16
    add eax, 32768
    sar eax, 16
    mov     eax, eax
    add rsp, 40
    ret
ex_18_round_fixed ENDP
main PROC
    sub     rsp, 40
    call    ex_18_round_fixed
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
