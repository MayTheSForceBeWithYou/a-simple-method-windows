; Exercise: 15-econ-ticket
;
; cash += ticket 15; from 0 exit 15.
; Expected stdout: (none)
; Expected exit: 15
;
.data
cash QWORD 0

.code
ex_15_econ_ticket PROC
    sub rsp, 40
    add QWORD PTR [cash], 15
    mov rcx, QWORD PTR [cash]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_econ_ticket ENDP
main PROC
    sub     rsp, 40
    call    ex_15_econ_ticket
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
