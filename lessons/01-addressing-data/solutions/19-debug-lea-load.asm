; Exercise 19: debug lea load
;
; BUG: used lea to 'load' value. Fix to mov from memory; x QWORD 55; exit 55.
;
; Build: ml64 /c 19-debug-lea-load.asm && link /OUT:19-debug-lea-load.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-lea-load.obj kernel32.lib
;
; Expected exit: 55

EXTERN ExitProcess:PROC

.data
x QWORD 55

.code
main PROC
    sub rsp, 32
    mov rcx, [x]
    call ExitProcess
main ENDP
END
