; 03-econ-tick: econ tick
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_econ_tick:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_econ_tick in this file.
    call    ex_03_econ_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
