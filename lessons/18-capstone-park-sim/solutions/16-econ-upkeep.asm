; Exercise 16: econ upkeep
;
; cash -= 3; from 10 exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
cash QWORD 0

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [cash], 10
    sub QWORD PTR [cash], 3
    mov rcx, QWORD PTR [cash]
    call ExitProcess
main ENDP
END
