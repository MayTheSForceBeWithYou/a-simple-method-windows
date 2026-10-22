; Exercise 14: ride queue len
;
; Queue length 7; exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
qlen QWORD 0

.code
ex_14_ride_queue_len PROC
    sub rsp, 40
    mov QWORD PTR [qlen], 7
        mov     eax, QWORD PTR [qlen]
    add     rsp, 40
    ret
ex_14_ride_queue_len ENDP
main PROC
    call    ex_14_ride_queue_len
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
