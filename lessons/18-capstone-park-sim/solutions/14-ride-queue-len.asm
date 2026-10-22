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
mov QWORD PTR [qlen], 7
    mov rcx, QWORD PTR [qlen]
    mov     eax, ecx
    ret
ex_14_ride_queue_len ENDP
main PROC
    sub     rsp, 40
    call    ex_14_ride_queue_len
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
