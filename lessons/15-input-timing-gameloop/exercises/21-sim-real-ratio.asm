; 21-sim-real-ratio: sim real ratio
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_sim_real_ratio:PROC
main PROC
    ; TODO: write ex_21_sim_real_ratio in this file.
    call    ex_21_sim_real_ratio
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
