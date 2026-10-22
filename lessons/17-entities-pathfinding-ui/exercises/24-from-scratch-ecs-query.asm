; 24-from-scratch-ecs-query: from scratch ecs query
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_ecs_query:PROC
main PROC
    ; TODO: implement ex_24_from_scratch_ecs_query (student routine; defined in solutions/).
    call    ex_24_from_scratch_ecs_query
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
