; Exercise 07: clip w
;
; sprite w clipped; exit 2.
;
; Build: ml64 /c 07-clip-w.asm && link /OUT:07-clip-w.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-clip-w.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 2
    call ExitProcess
main ENDP
END
