; 21-sim-real-ratio: sim real ratio
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_sim_real_ratio:PROC
main PROC
    ; TODO: implement ex_21_sim_real_ratio (student routine; defined in solutions/).
    call    ex_21_sim_real_ratio
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
