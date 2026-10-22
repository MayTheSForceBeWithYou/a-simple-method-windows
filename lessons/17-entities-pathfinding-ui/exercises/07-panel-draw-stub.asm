; 07-panel-draw-stub: panel draw stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_panel_draw_stub:PROC
main PROC
    ; TODO: write ex_07_panel_draw_stub in this file.
    call    ex_07_panel_draw_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
