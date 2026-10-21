; Exercise 22: stretch pratt stub
;
; STRETCH: binding power for + is 10, for * is 20; exit 20.
; Expected exit: 20

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 20
    call ExitProcess
main ENDP
END
