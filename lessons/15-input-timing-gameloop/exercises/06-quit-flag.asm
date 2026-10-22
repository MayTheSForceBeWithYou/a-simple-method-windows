; 06-quit-flag: quit flag
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_quit_flag:PROC
main PROC
    ; TODO: implement ex_06_quit_flag (student routine; defined in solutions/).
    call    ex_06_quit_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
