; Exercise 23: stretch error span
;
; STRETCH: error at offset 4 length 1; exit 4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.data?
err_off QWORD ?

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [err_off], 4
    mov rcx, QWORD PTR [err_off]
    call ExitProcess
main ENDP
END
