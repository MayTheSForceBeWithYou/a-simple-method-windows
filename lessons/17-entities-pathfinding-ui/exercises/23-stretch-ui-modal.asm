; 23-stretch-ui-modal: stretch ui modal
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_ui_modal:PROC
main PROC
    ; TODO: implement ex_23_stretch_ui_modal (student routine; defined in solutions/).
    call    ex_23_stretch_ui_modal
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
