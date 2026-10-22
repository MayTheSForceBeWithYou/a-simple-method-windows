; 16-econ-upkeep: econ upkeep
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_econ_upkeep:PROC
main PROC
    ; TODO: write ex_16_econ_upkeep in this file.
    call    ex_16_econ_upkeep
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
