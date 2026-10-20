; Exercise 11: parse binop
;
; AST for 2+3 folds to 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 2
    add rcx, 3
    call ExitProcess
main ENDP
END
