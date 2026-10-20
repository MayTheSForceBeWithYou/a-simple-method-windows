; Exercise 06: rd parse num
;
; Parse '3' into value; exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
s BYTE "3", 0

.code
main PROC
    sub rsp, 32
    movzx rcx, BYTE PTR [s]
    sub rcx, '0'
    call ExitProcess
main ENDP
END
