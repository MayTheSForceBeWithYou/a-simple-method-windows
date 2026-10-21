; Exercise 15: econ ticket
;
; cash += ticket 15; from 0 exit 15.
;
; Expected exit: 15
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
cash QWORD 0

.code
main PROC
    sub rsp, 40
    add QWORD PTR [cash], 15
    mov rcx, QWORD PTR [cash]
    call ExitProcess
main ENDP
END
