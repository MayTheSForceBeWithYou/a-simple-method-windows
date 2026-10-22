; 18-ast-node
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_ast_node:PROC
main PROC
    ; TODO: implement ex_18_ast_node (student routine; defined in solutions/).
    call    ex_18_ast_node
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
