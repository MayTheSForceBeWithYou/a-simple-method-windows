; 20-tile-autotile-mask: tile autotile mask
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_tile_autotile_mask:PROC
main PROC
    ; TODO: implement ex_20_tile_autotile_mask (student routine; defined in solutions/).
    call    ex_20_tile_autotile_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
