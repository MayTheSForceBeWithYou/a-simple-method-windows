; Exercise 16: econ upkeep
;
; cash -= 3; from 10 exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
cash QWORD 0

.code
ex_16_econ_upkeep PROC
    sub rsp, 40
    mov QWORD PTR [cash], 10
    sub QWORD PTR [cash], 3
    mov rcx, QWORD PTR [cash]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_econ_upkeep ENDP
main PROC
    sub     rsp, 40
    call    ex_16_econ_upkeep
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
