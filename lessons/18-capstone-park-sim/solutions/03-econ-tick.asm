; Exercise: 03-econ-tick
;
; cash+=5; exit cash 5.
; Expected stdout: (none)
; Expected exit: 5
;
.data?
cash QWORD ?

.code
ex_03_econ_tick PROC
    sub rsp, 40
    add QWORD PTR [cash], 5
    mov rcx, [cash]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_econ_tick ENDP
main PROC
    sub     rsp, 40
    call    ex_03_econ_tick
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
