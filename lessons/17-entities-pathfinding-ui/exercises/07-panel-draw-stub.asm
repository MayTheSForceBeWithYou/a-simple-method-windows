; Exercise: 07-panel-draw-stub
;
; Draw count 3 widgets; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_07_panel_draw_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_panel_draw_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_panel_draw_stub in this file.
    call    ex_07_panel_draw_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
