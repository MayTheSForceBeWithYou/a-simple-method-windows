; 02-place-track: place track
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_place_track:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_place_track in this file.
    call    ex_02_place_track
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
