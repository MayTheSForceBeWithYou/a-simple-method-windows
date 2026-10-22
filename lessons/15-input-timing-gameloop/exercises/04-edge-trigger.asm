; 04-edge-trigger: edge trigger
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_edge_trigger:PROC
main PROC
    ; TODO: implement ex_04_edge_trigger (student routine; defined in solutions/).
    call    ex_04_edge_trigger
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
