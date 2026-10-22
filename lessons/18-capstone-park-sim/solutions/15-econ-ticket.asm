; Exercise 15: econ ticket
;
; cash += ticket 15; from 0 exit 15.
;
; Expected exit: 15
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
cash QWORD 0

.code
ex_15_econ_ticket PROC
    sub rsp, 40
    add QWORD PTR [cash], 15
        mov     eax, QWORD PTR [cash]
    ret
    add     rsp, 40
ex_15_econ_ticket ENDP
main PROC
    call    ex_15_econ_ticket
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
