; 14-tile-collision-mask: tile collision mask
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_tile_collision_mask:PROC
main PROC
    ; TODO: implement ex_14_tile_collision_mask (student routine; defined in solutions/).
    call    ex_14_tile_collision_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
