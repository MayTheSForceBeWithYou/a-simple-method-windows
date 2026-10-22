; 01-tile-index: tile index
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_tile_index:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_tile_index in this file.
    call    ex_01_tile_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
