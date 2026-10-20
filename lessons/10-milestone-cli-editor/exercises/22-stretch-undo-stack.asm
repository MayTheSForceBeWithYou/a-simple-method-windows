; 22-stretch-undo-stack.asm: Push edit action onto stack, exit stack_top
.DATA?
undo_stack DQ 16 DUP(?)
stack_top QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov stack_top, 0
    .ERR <TODO: Push action (e.g. 42) onto undo_stack, inc stack_top, exit stack_top>
main ENDP
END
