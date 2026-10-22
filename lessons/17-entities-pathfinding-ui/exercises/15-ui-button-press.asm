; Exercise: 15-ui-button-press
;
; Exercise 15: ui button press
; Hit + mouse down -> pressed; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_15_ui_button_press` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 15-ui-button-press: ui button press
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_ui_button_press:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_ui_button_press in this file.
    call    ex_15_ui_button_press
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
