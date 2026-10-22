; 01-tile-index: tile index
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_tile_index:PROC
main PROC
    ; TODO: implement ex_01_tile_index (student routine; defined in solutions/).
    call    ex_01_tile_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
