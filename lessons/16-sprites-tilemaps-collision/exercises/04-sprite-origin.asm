; 04-sprite-origin: sprite origin
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_sprite_origin:PROC
main PROC
    ; TODO: implement ex_04_sprite_origin (student routine; defined in solutions/).
    call    ex_04_sprite_origin
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
