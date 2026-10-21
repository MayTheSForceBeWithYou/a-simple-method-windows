; Exercise 11: debug wrong syscall
;
; BUG HUNT: Intends to exit status 3 but uses wrong function. Fix it.
;
; Build: ml64 /c 11-debug-wrong-syscall.asm && link /OUT:11-debug-wrong-syscall.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-debug-wrong-syscall.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 3
    call ExitProcess
main ENDP
END
