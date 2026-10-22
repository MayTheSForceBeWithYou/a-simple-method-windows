; 15-ui-button-press: ui button press
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_ui_button_press:PROC
main PROC
    ; TODO: implement ex_15_ui_button_press (student routine; defined in solutions/).
    call    ex_15_ui_button_press
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
