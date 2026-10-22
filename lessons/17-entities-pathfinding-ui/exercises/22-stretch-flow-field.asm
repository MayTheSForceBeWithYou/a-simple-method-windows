; 22-stretch-flow-field: stretch flow field
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_flow_field:PROC
main PROC
    ; TODO: implement ex_22_stretch_flow_field (student routine; defined in solutions/).
    call    ex_22_stretch_flow_field
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
