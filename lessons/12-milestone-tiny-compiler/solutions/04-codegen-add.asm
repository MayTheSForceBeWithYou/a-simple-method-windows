; Exercise 04: codegen add
;
; Fold 2+3 at compile-time; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 2
    add rcx, 3
    call ExitProcess
main ENDP
END
