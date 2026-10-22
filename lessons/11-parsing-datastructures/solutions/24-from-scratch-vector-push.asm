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

ex_24_from_scratch_vector_push PROC
sub rsp, 40
    mov QWORD PTR [cap], 8
    mov QWORD PTR [len], 0
    call push1
    call push1
    call push1
    mov     eax, 3
    ret
ex_24_from_scratch_vector_push ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_vector_push
    mov     rcx, rax
    call    ExitProcess
main ENDP

push1 PROC
    mov rcx, QWORD PTR [len]
    lea r11, [data]
    mov QWORD PTR [r11+rcx*8], 1
    inc QWORD PTR [len]
    ret
push1 ENDP
END
