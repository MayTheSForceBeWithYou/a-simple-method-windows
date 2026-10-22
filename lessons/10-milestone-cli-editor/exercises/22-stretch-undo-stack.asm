; 22-stretch-undo-stack.asm: Push edit action onto stack, exit stack_top
.DATA?
undo_stack DQ 16 DUP(?)
stack_top QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_undo_stack:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_22_stretch_undo_stack (student routine; defined in solutions/).
    call    ex_22_stretch_undo_stack
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
