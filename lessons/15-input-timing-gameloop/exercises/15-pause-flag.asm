; Exercise: 15-pause-flag
;
; Paused skips update; updates=0; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_15_pause_flag` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
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
