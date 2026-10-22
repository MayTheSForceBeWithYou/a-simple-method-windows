; 16-ui-focus: ui focus
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_ui_focus:PROC
main PROC
    ; TODO: implement ex_16_ui_focus (student routine; defined in solutions/).
    call    ex_16_ui_focus
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
