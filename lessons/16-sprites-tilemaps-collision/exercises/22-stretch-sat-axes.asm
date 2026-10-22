; 22-stretch-sat-axes: stretch sat axes
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_sat_axes:PROC
main PROC
    ; TODO: implement ex_22_stretch_sat_axes (student routine; defined in solutions/).
    call    ex_22_stretch_sat_axes
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
