; 15-pause-flag: pause flag
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_pause_flag:PROC
main PROC
    ; TODO: implement ex_15_pause_flag (student routine; defined in solutions/).
    call    ex_15_pause_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
