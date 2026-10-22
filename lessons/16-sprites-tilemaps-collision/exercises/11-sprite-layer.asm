; 11-sprite-layer: sprite layer
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_sprite_layer:PROC
main PROC
    ; TODO: implement ex_11_sprite_layer (student routine; defined in solutions/).
    call    ex_11_sprite_layer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
