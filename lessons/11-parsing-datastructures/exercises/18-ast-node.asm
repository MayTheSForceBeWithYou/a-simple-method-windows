; Exercise: 18-ast-node
;
; AST node kind=1 left=2 right=3; exit kind+left+right=6.
;
; Contract: implement `ex_18_ast_node` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_18_ast_node:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_ast_node in this file.
    call    ex_18_ast_node
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
