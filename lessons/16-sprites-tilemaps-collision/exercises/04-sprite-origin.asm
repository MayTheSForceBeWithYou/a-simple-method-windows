; 04-sprite-origin: sprite origin
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_sprite_origin:PROC
main PROC
    ; TODO: write ex_04_sprite_origin in this file.
    call    ex_04_sprite_origin
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
