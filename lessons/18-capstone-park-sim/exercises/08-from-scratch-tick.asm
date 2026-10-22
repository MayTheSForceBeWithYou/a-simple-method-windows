; 08-from-scratch-tick: from scratch tick
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_tick:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_tick in this file.
    call    ex_08_from_scratch_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
