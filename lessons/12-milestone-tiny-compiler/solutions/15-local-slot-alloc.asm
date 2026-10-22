; Exercise: 15-local-slot-alloc
;
; Allocate 3 locals; next_slot=3; exit 3.
; Expected exit: 3
;
.data?
next_slot QWORD ?

.code
ex_15_local_slot_alloc PROC
    sub rsp, 40
    mov QWORD PTR [next_slot], 0
    inc QWORD PTR [next_slot]
    inc QWORD PTR [next_slot]
    inc QWORD PTR [next_slot]
    mov rcx, QWORD PTR [next_slot]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_local_slot_alloc ENDP
main PROC
    sub     rsp, 40
    call    ex_15_local_slot_alloc
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
