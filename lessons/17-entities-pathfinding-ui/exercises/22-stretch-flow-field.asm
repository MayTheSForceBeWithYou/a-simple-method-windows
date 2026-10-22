; 22-stretch-flow-field: stretch flow field
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_flow_field:PROC
main PROC
    ; TODO: write ex_22_stretch_flow_field in this file.
    call    ex_22_stretch_flow_field
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
