; 24-from-scratch-sim-integrate: from scratch sim integrate
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_sim_integrate:PROC
main PROC
    ; TODO: write ex_24_from_scratch_sim_integrate in this file.
    call    ex_24_from_scratch_sim_integrate
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
