; Exercise: 12-track-connect
;
; Exercise 12: track connect
; Two pieces connect if dirs match; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_12_track_connect` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 12-track-connect: track connect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_track_connect:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_track_connect in this file.
    call    ex_12_track_connect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
