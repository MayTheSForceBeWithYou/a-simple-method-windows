; Exercise 07: emit syscall exit
;
; Hand-written 'codegen' template exits status 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor rcx, rcx
    call ExitProcess
main ENDP
END
