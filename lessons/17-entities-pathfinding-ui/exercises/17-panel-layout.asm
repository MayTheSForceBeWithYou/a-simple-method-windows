; Exercise: 17-panel-layout
;
; Stack y += h+pad; h=10 pad=2 twice from 0 -> 24; exit 24.
; Expected stdout: (none)
;
; Contract: implement `ex_17_panel_layout` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 24
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_panel_layout:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_panel_layout in this file.
    call    ex_17_panel_layout
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
