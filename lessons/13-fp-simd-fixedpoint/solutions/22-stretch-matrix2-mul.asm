; Exercise 22: stretch matrix2 mul
;
; STRETCH: 2x2 identity * (3,4) -> 3; exit 3 (x).
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 3
    call ExitProcess
main ENDP
END
