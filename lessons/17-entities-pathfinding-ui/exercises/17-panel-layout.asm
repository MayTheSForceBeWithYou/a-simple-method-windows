; 17-panel-layout: panel layout
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_panel_layout:PROC
main PROC
    ; TODO: write ex_17_panel_layout in this file.
    call    ex_17_panel_layout
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
