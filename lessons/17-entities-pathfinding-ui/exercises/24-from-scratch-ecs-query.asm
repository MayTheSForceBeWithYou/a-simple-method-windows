; Exercise: 24-from-scratch-ecs-query
;
; FROM SCRATCH: count entities with mask POS; 3 of 4; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_ecs_query` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_ecs_query:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_ecs_query in this file.
    call    ex_24_from_scratch_ecs_query
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
