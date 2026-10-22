; 09-spawn-entity: spawn entity
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_spawn_entity:PROC
main PROC
    ; TODO: implement ex_09_spawn_entity (student routine; defined in solutions/).
    call    ex_09_spawn_entity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
