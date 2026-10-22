; 21-formation-slot: formation slot
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_formation_slot:PROC
main PROC
    ; TODO: implement ex_21_formation_slot (student routine; defined in solutions/).
    call    ex_21_formation_slot
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
