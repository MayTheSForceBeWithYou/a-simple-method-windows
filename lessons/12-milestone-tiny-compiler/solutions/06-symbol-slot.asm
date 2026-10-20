; Exercise 06: symbol slot
;
; Bind name slot 0 to 42; lookup exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
slots QWORD 4 DUP(?)

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [slots], 42
    mov rcx, QWORD PTR [slots]
    call ExitProcess
main ENDP
END
