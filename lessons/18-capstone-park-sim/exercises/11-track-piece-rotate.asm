; 11-track-piece-rotate: track piece rotate
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_track_piece_rotate:PROC
main PROC
    ; TODO: implement ex_11_track_piece_rotate (student routine; defined in solutions/).
    call    ex_11_track_piece_rotate
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
