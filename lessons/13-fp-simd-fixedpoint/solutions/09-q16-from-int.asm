; Exercise 09: q16 from int
;
; Convert 5 to Q16.16; >>16 back exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_09_q16_from_int PROC
    sub rsp, 40
    mov eax, 5
    shl eax, 16
    shr eax, 16
    mov ecx, eax
    mov     eax, eax
    add     rsp, 40
    ret
ex_09_q16_from_int ENDP
main PROC
    sub     rsp, 40
    call    ex_09_q16_from_int
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
