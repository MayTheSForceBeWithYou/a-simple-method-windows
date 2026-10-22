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

ex_20_queue_ring PROC
sub rsp, 40
    mov QWORD PTR [head], 0
    mov QWORD PTR [tail], 0
    mov rcx, QWORD PTR [tail]
    lea r11, [q]
    mov QWORD PTR [r11+rcx*8], 7
    inc QWORD PTR [tail]
    mov rcx, QWORD PTR [tail]
    lea r11, [q]
    mov QWORD PTR [r11+rcx*8], 8
    inc QWORD PTR [tail]
    mov rcx, QWORD PTR [head]
    lea r11, [q]
    mov rcx, QWORD PTR [r11+rcx*8]
    inc QWORD PTR [head]
    mov     eax, 7
    ret
ex_20_queue_ring ENDP
main PROC
    sub     rsp, 40
    call    ex_20_queue_ring
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
