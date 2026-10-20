; Exercise 20: type check int
;
; Type tag int=1; expression type int; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

TY_INT EQU 1

.code
main PROC
    sub rsp, 32
    mov rcx, TY_INT
    call ExitProcess
main ENDP
END
