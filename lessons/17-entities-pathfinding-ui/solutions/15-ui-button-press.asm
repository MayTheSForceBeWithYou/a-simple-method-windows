; Exercise: 15-ui-button-press
;
; Hit + mouse down -> pressed; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_15_ui_button_press PROC
    sub rsp, 40
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_15_ui_button_press ENDP
main PROC
    sub     rsp, 40
    call    ex_15_ui_button_press
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
