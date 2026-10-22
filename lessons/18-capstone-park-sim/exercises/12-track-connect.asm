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
