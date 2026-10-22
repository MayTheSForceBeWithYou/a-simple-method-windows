; Exercise: 09-spawn-entity
;
; Exercise 09: spawn entity
; Bump entity id; first spawn id=1; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_09_spawn_entity` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 09-spawn-entity: spawn entity
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_spawn_entity:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_spawn_entity in this file.
    call    ex_09_spawn_entity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
