; Exercise 23: stretch symbol resolve
;
; STRETCH: symbol table maps name hash to addr 020h; exit 020h=32.
; Expected exit: 32

EXTERN ExitProcess:PROC

.data?
sym QWORD ?

.code
ex_23_stretch_symbol_resolve PROC
    sub rsp, 40
    mov QWORD PTR [sym], 32
    mov rcx, QWORD PTR [sym]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_23_stretch_symbol_resolve ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_symbol_resolve
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
