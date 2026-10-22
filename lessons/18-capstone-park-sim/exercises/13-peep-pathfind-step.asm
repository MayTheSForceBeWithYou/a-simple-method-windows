; 13-peep-pathfind-step: peep pathfind step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_peep_pathfind_step:PROC
main PROC
    ; TODO: implement ex_13_peep_pathfind_step (student routine; defined in solutions/).
    call    ex_13_peep_pathfind_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
