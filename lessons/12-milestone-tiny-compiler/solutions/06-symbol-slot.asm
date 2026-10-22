; Exercise 06: symbol slot
;
; Bind name slot 0 to 42; lookup exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
slots QWORD 4 DUP(?)

.code

ex_06_symbol_slot PROC
mov QWORD PTR [slots], 42
    mov rcx, QWORD PTR [slots]
    mov     eax, QWORD PTR [slots]
    ret
ex_06_symbol_slot ENDP
main PROC
    sub     rsp, 40
    call    ex_06_symbol_slot
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
