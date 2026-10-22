; 14-tile-collision-mask: tile collision mask
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_tile_collision_mask:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_tile_collision_mask in this file.
    call    ex_14_tile_collision_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
