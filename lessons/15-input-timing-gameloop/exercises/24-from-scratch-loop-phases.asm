; 24-from-scratch-loop-phases: from scratch loop phases
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_loop_phases:PROC
main PROC
    ; TODO: implement ex_24_from_scratch_loop_phases (student routine; defined in solutions/).
    call    ex_24_from_scratch_loop_phases
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
