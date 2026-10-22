; 11-sprite-layer: sprite layer
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_sprite_layer:PROC
main PROC
    ; TODO: write ex_11_sprite_layer in this file.
    call    ex_11_sprite_layer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
