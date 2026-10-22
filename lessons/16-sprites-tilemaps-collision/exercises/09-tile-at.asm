; 09-tile-at: tile at
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_tile_at:PROC
main PROC
    ; TODO: write ex_09_tile_at in this file.
    call    ex_09_tile_at
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
