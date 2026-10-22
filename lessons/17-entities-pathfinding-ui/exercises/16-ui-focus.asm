; 16-ui-focus: ui focus
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
