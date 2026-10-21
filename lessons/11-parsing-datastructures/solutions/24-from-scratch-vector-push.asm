; Exercise 24: from scratch vector push
;
; FROM SCRATCH: dynamic array len/cap; push 3 values; exit len 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data?
data QWORD 8 DUP(?)
len QWORD ?
cap QWORD ?

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [cap], 8
    mov QWORD PTR [len], 0
    call push1
    call push1
    call push1
    mov rcx, QWORD PTR [len]
    call ExitProcess
main ENDP

push1 PROC
    mov rcx, QWORD PTR [len]
    lea r11, [data]
    mov QWORD PTR [r11+rcx*8], 1
    inc QWORD PTR [len]
    ret
push1 ENDP
END
