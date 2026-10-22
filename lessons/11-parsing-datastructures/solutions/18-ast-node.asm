; Exercise 18: ast node
;
; AST node kind=1 left=2 right=3; exit kind+left+right=6.
; Expected exit: 6

EXTERN ExitProcess:PROC

.data?
node QWORD 3 DUP(?)

.code

ex_18_ast_node PROC
mov QWORD PTR [node], 1
    mov QWORD PTR [node+8], 2
    mov QWORD PTR [node+16], 3
    mov rcx, QWORD PTR [node]
    add rcx, QWORD PTR [node+8]
    add rcx, QWORD PTR [node+16]
    mov     eax, ecx
    ret
ex_18_ast_node ENDP
main PROC
    sub     rsp, 40
    call    ex_18_ast_node
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
