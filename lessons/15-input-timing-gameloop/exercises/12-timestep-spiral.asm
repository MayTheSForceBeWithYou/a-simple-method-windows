; 12-timestep-spiral: timestep spiral
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_timestep_spiral:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_timestep_spiral in this file.
    call    ex_12_timestep_spiral
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
