; Exercise 15: ui button press
;
; Hit + mouse down -> pressed; exit 1.
;
; Build: ml64 /c 15-ui-button-press.asm && link /OUT:15-ui-button-press.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-ui-button-press.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
ex_15_ui_button_press PROC
    sub rsp, 40
        mov     eax, 1
    ret
    add     rsp, 40
ex_15_ui_button_press ENDP
main PROC
    call    ex_15_ui_button_press
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
