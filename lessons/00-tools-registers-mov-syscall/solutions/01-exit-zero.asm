; Exercise 01: exit zero
;
; Exit with status 0 using ExitProcess.
;
; Build: ml64 /c 01-exit-zero.asm && link /OUT:01-exit-zero.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-exit-zero.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 0
    call ExitProcess
main ENDP
END
