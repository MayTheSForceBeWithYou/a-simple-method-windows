; Exercise 01: emit mov imm
;
; Compiler-ish: 'emit' by writing value 42 to out cell; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
outv QWORD ?

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [outv], 42
    mov rcx, QWORD PTR [outv]
    call ExitProcess
main ENDP
END
