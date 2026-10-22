; Exercise 23: stretch symbol resolve
;
; STRETCH: symbol table maps name hash to addr 0x20; exit 0x20=32.
; Expected exit: 32

EXTERN ExitProcess:PROC

.data?
sym QWORD ?

.code

ex_23_stretch_symbol_resolve PROC
mov QWORD PTR [sym], 32
    mov rcx, QWORD PTR [sym]
    mov     eax, QWORD PTR [sym]
    ret
ex_23_stretch_symbol_resolve ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_symbol_resolve
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
