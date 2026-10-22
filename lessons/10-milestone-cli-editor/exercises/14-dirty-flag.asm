; 14-dirty-flag.asm: Set dirty=1 on edit, clear on save, exit dirty
.DATA?
dirty QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_dirty_flag:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_dirty_flag in this file.
    call    ex_14_dirty_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
