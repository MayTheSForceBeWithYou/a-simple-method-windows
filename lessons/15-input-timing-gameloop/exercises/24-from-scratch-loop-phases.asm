; 24-from-scratch-loop-phases: from scratch loop phases
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_loop_phases:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_loop_phases in this file.
    call    ex_24_from_scratch_loop_phases
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
