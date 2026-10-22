; 06-quit-flag: quit flag
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_quit_flag:PROC
main PROC
    ; TODO: write ex_06_quit_flag in this file.
    call    ex_06_quit_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
