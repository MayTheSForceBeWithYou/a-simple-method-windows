; 16-expr-stack
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_expr_stack:PROC
main PROC
    ; TODO: implement ex_16_expr_stack (student routine; defined in solutions/).
    call    ex_16_expr_stack
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
