; Exercise 19: debug offset bpp
;
; BUG: used *3 for RGBA8888. Fix *4; x=2 offset=8; exit 8.
;
; Build: ml64 /c 19-debug-offset-bpp.asm && link /OUT:19-debug-offset-bpp.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-offset-bpp.obj kernel32.lib
;
; Expected exit: 8
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 2
    imul rcx, 4
    call ExitProcess
main ENDP
END
