; 05-entity-alive: entity alive
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_entity_alive:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_entity_alive in this file.
    call    ex_05_entity_alive
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
