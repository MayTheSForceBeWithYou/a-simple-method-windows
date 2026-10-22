; Exercise 11: parse binop
;
; AST for 2+3 folds to 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code

ex_11_parse_binop PROC
sub rsp, 40
    mov rcx, 2
    add rcx, 3
    mov     eax, 5
    ret
ex_11_parse_binop ENDP
main PROC
    sub     rsp, 40
    call    ex_11_parse_binop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
