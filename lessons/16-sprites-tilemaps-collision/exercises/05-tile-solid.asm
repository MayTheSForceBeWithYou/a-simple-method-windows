; 05-tile-solid: tile solid
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_tile_solid:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_tile_solid in this file.
    call    ex_05_tile_solid
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
