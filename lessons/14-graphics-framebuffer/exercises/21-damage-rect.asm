; 21-damage-rect: damage rect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_damage_rect:PROC
main PROC
    ; TODO: implement ex_21_damage_rect (student routine; defined in solutions/).
    call    ex_21_damage_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
