; Exercise: 16-ui-focus
;
; Tab cycles focus index mod 3; from 2 -> 0; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_16_ui_focus` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_ui_focus:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_ui_focus in this file.
    call    ex_16_ui_focus
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
