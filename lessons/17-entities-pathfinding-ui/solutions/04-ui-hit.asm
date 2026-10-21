; Exercise 04: ui hit
;
; Point in panel -> 1.
;
; Build: ml64 /c 04-ui-hit.asm && link /OUT:04-ui-hit.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-ui-hit.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 1
    call ExitProcess
main ENDP
END
