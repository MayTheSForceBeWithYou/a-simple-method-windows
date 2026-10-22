; 24-from-scratch-ecs-query: from scratch ecs query
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
