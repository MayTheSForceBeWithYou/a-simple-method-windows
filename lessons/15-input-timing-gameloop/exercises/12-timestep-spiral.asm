; 12-timestep-spiral: timestep spiral
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_timestep_spiral:PROC
main PROC
    ; TODO: implement ex_12_timestep_spiral (student routine; defined in solutions/).
    call    ex_12_timestep_spiral
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
