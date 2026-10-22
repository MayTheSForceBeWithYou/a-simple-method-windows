; 21-formation-slot: formation slot
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_formation_slot:PROC
main PROC
    ; TODO: write ex_21_formation_slot in this file.
    call    ex_21_formation_slot
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
