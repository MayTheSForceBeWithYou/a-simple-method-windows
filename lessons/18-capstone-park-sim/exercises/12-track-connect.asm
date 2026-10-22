; 12-track-connect: track connect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_track_connect:PROC
main PROC
    ; TODO: implement ex_12_track_connect (student routine; defined in solutions/).
    call    ex_12_track_connect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
