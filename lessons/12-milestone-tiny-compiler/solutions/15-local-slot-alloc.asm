; Exercise 15: local slot alloc
;
; Allocate 3 locals; next_slot=3; exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data?
next_slot QWORD ?

.code
ex_15_local_slot_alloc PROC
    sub rsp, 40
    mov QWORD PTR [next_slot], 0
    inc QWORD PTR [next_slot]
    inc QWORD PTR [next_slot]
    inc QWORD PTR [next_slot]
        mov     eax, QWORD PTR [next_slot]
    ret

ex_15_local_slot_alloc ENDP
main PROC
    call    ex_15_local_slot_alloc
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
