; Exercise 24: from scratch sim integrate
;
; FROM SCRATCH: one tick: place path, peep step, cash+=1; exit cash 1.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
peep_x QWORD 0
cash QWORD 0

.data?
map BYTE 256 DUP(0)

.code
ex_24_from_scratch_sim_integrate PROC
    sub rsp, 40
    mov BYTE PTR [map], 1
    inc QWORD PTR [peep_x]
    inc QWORD PTR [cash]
        mov     eax, QWORD PTR [cash]
    add     rsp, 40
    ret
ex_24_from_scratch_sim_integrate ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_sim_integrate
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
