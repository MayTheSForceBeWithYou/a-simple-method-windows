; Exercise 08: from scratch token buf
;
; FROM SCRATCH: store ascii 'x' as token lexeme len 1; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data?
lex BYTE 8 DUP(?)
n QWORD ?

.code
main PROC
    sub rsp, 40
    mov BYTE PTR [lex], 'x'
    mov QWORD PTR [n], 1
    mov rcx, QWORD PTR [n]
    call ExitProcess
main ENDP
END
