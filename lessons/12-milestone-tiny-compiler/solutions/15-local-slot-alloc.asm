; Exercise 15: local slot alloc
;
; Allocate 3 locals; next_slot=3; exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data?
next_slot QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [next_slot], 0
    inc QWORD PTR [next_slot]
    inc QWORD PTR [next_slot]
    inc QWORD PTR [next_slot]
    mov rcx, QWORD PTR [next_slot]
    call ExitProcess
main ENDP
END
