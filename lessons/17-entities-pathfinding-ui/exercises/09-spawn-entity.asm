; 09-spawn-entity: spawn entity
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_spawn_entity:PROC
main PROC
    ; TODO: write ex_09_spawn_entity in this file.
    call    ex_09_spawn_entity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
