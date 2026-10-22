; Exercise 06: shift div
;
; Divide by 4 via sar; 20>>2=5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_06_shift_div PROC
    sub rsp, 40
    mov rcx, 20
    sar rcx, 2
    mov     eax, 5
    ret
    add     rsp, 40
ex_06_shift_div ENDP
main PROC
    call    ex_06_shift_div
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
