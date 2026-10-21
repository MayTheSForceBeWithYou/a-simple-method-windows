; Exercise 04: sprite origin
;
; screen = world - camera; 50-20=30.
;
; Build: ml64 /c 04-sprite-origin.asm && link /OUT:04-sprite-origin.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-sprite-origin.obj kernel32.lib
;
; Expected exit: 30
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 50
    sub rcx, 20
    call ExitProcess
main ENDP
END
