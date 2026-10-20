; Exercise 20: queue ring
;
; Ring buffer cap 4; enqueue 7,8; dequeue; exit 7.
; Expected exit: 7

EXTERN ExitProcess:PROC

.data?
q QWORD 4 DUP(?)
head QWORD ?
tail QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [head], 0
    mov QWORD PTR [tail], 0
    mov rcx, QWORD PTR [tail]
    mov QWORD PTR [q+rcx*8], 7
    inc QWORD PTR [tail]
    mov rcx, QWORD PTR [tail]
    mov QWORD PTR [q+rcx*8], 8
    inc QWORD PTR [tail]
    mov rcx, QWORD PTR [head]
    mov rcx, QWORD PTR [q+rcx*8]
    inc QWORD PTR [head]
    call ExitProcess
main ENDP
END
