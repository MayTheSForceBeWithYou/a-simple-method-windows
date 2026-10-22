; 08-from-scratch-tick: from scratch tick
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_tick:PROC
main PROC
    ; TODO: implement ex_08_from_scratch_tick (student routine; defined in solutions/).
    call    ex_08_from_scratch_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
