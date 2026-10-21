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
    
main PROC
    sub rsp, 40
    mov rcx, 1
    call ExitProcess

main ENDP
END
