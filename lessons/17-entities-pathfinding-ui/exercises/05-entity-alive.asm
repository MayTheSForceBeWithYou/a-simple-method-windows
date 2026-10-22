; 05-entity-alive: entity alive
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_entity_alive:PROC
main PROC
    ; TODO: implement ex_05_entity_alive (student routine; defined in solutions/).
    call    ex_05_entity_alive
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
