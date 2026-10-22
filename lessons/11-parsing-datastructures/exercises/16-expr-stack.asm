; 16-expr-stack
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_expr_stack:PROC
main PROC
    ; TODO: write ex_16_expr_stack in this file.
    call    ex_16_expr_stack
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
