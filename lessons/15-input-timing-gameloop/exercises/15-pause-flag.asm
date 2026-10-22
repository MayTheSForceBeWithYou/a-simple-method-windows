; 15-pause-flag: pause flag
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_pause_flag:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_pause_flag in this file.
    call    ex_15_pause_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
