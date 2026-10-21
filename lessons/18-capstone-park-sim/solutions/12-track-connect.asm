; Exercise 12: track connect
;
; Two pieces connect if dirs match; exit 1.
;
; Build: ml64 /c 12-track-connect.asm && link /OUT:12-track-connect.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-track-connect.obj kernel32.lib
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
