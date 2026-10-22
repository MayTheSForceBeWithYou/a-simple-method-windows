; 03-econ-tick: econ tick
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_econ_tick:PROC
main PROC
    ; TODO: implement ex_03_econ_tick (student routine; defined in solutions/).
    call    ex_03_econ_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
