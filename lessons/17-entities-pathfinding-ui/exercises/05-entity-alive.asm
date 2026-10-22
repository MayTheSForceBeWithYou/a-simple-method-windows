; Exercise: 05-entity-alive
;
; flags bit0 alive; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_05_entity_alive` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
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
