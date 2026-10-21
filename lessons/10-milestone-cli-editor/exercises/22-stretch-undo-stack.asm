; 22-stretch-undo-stack.asm: Push edit action onto stack, exit stack_top
.DATA?
undo_stack DQ 16 DUP(?)
stack_top QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov stack_top, 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
