; Exercise 24: from scratch compile add
;
; FROM SCRATCH: compile-time eval of 40+2; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 40
    add rcx, 2
    call ExitProcess
main ENDP
END
