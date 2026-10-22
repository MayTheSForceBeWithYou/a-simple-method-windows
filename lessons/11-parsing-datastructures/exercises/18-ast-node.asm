; 18-ast-node
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_ast_node:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_ast_node in this file.
    call    ex_18_ast_node
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
