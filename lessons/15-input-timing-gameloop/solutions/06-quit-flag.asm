; Exercise 06: quit flag
;
; quit dq 1; exit quit.
;
; Build: ml64 /c 06-quit-flag.asm && link /OUT:06-quit-flag.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-quit-flag.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
quit QWORD 1

.code
main PROC
    sub rsp, 40
    mov rcx, [quit]
    call ExitProcess
main ENDP
END
