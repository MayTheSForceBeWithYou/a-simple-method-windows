; 04-edge-trigger: edge trigger
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_edge_trigger:PROC
main PROC
    ; TODO: write ex_04_edge_trigger in this file.
    call    ex_04_edge_trigger
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
