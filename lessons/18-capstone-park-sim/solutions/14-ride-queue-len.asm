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
main PROC
    sub rsp, 40
    mov QWORD PTR [qlen], 7
    mov rcx, QWORD PTR [qlen]
    call ExitProcess
main ENDP
END
