; 13-peep-pathfind-step: peep pathfind step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_peep_pathfind_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_peep_pathfind_step in this file.
    call    ex_13_peep_pathfind_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
