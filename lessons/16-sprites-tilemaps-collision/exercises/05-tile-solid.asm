; 05-tile-solid: tile solid
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_tile_solid:PROC
main PROC
    ; TODO: implement ex_05_tile_solid (student routine; defined in solutions/).
    call    ex_05_tile_solid
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
