; Exercise: 23-stretch-ui-modal
;
; STRETCH: modal stack depth 1; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_23_stretch_ui_modal` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_ui_modal:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_ui_modal in this file.
    call    ex_23_stretch_ui_modal
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
