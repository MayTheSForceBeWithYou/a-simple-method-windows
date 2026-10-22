; 08-from-scratch-loop-counter: from scratch loop counter
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_loop_counter:PROC
main PROC
    ; TODO: write ex_08_from_scratch_loop_counter in this file.
    call    ex_08_from_scratch_loop_counter
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
