; Exercise: 14-frame-stats
;
; fps counter frames=60 over 1s; exit 60.
; Expected stdout: (none)
;
; Contract: implement `ex_14_frame_stats` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 60
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_14_frame_stats:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_frame_stats in this file.
    call    ex_14_frame_stats
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
