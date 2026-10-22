; 17-panel-layout: panel layout
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_panel_layout:PROC
main PROC
    ; TODO: implement ex_17_panel_layout (student routine; defined in solutions/).
    call    ex_17_panel_layout
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
