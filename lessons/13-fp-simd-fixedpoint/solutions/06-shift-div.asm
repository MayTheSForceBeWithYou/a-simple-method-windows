; Exercise 06: shift div
;
; Divide by 4 via sar; 20>>2=5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 20
    sar rcx, 2
    call ExitProcess
main ENDP
END
