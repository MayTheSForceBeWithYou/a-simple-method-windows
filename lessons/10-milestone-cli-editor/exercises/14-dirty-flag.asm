; 14-dirty-flag.asm: Set dirty=1 on edit, clear on save, exit dirty
.DATA?
dirty QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_dirty_flag:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_14_dirty_flag (student routine; defined in solutions/).
    call    ex_14_dirty_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
