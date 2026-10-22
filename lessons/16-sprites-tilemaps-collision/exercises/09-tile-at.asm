; 09-tile-at: tile at
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_tile_at:PROC
main PROC
    ; TODO: implement ex_09_tile_at (student routine; defined in solutions/).
    call    ex_09_tile_at
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
