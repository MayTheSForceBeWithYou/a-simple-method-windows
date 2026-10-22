; 20-tile-autotile-mask: tile autotile mask
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_tile_autotile_mask:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_tile_autotile_mask in this file.
    call    ex_20_tile_autotile_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
