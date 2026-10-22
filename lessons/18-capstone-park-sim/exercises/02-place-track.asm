; 02-place-track: place track
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_place_track:PROC
main PROC
    ; TODO: implement ex_02_place_track (student routine; defined in solutions/).
    call    ex_02_place_track
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
