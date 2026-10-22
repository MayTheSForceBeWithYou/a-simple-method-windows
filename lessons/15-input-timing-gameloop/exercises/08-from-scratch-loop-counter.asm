; 08-from-scratch-loop-counter: from scratch loop counter
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_loop_counter:PROC
main PROC
    ; TODO: implement ex_08_from_scratch_loop_counter (student routine; defined in solutions/).
    call    ex_08_from_scratch_loop_counter
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
