; Exercise: 12-track-connect
;
; Input: piece A exit dir and piece B entry dir (stub uses dir=1). Return 1 if they connect (dirs match), else 0; exit with that result (1).
; Expected stdout: (none)
;
; Contract: implement `ex_12_track_connect` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_12_track_connect:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_track_connect in this file.
    call    ex_12_track_connect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
