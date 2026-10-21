; Exercise 15: pause flag
;
; Paused skips update; updates=0; exit 0.
;
; Build: ml64 /c 15-pause-flag.asm && link /OUT:15-pause-flag.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-pause-flag.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
paused BYTE ?
updates QWORD ?

.code
main PROC
    sub rsp, 40
    mov BYTE PTR [paused], 1
    cmp BYTE PTR [paused], 0
    jne skip_update
    inc QWORD PTR [updates]
skip_update:
    mov rcx, [updates]
    call ExitProcess
main ENDP
END
