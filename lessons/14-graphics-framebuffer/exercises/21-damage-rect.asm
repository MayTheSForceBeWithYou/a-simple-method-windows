; 21-damage-rect: damage rect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_damage_rect:PROC
main PROC
    ; TODO: write ex_21_damage_rect in this file.
    call    ex_21_damage_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
