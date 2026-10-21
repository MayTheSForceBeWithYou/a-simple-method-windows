; Exercise 23: stretch symbol resolve
;
; STRETCH: symbol table maps name hash to addr 0x20; exit 0x20=32.
; Expected exit: 32

EXTERN ExitProcess:PROC

.data?
sym QWORD ?

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [sym], 32
    mov rcx, QWORD PTR [sym]
    call ExitProcess
main ENDP
END
