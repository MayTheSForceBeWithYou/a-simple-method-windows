; 22-stretch-sat-axes: stretch sat axes
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_sat_axes:PROC
main PROC
    ; TODO: write ex_22_stretch_sat_axes in this file.
    call    ex_22_stretch_sat_axes
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
