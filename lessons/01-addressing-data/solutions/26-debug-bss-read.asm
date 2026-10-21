; Exercise 26: debug bss read
;
; BUG: reads .data? before store (0). Store 12 first; exit 12.
;
; Build: ml64 /c 26-debug-bss-read.asm && link /OUT:26-debug-bss-read.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-debug-bss-read.obj kernel32.lib
;
; Expected exit: 12

EXTERN ExitProcess:PROC

.data?
v QWORD ?

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [v], 12
    mov rcx, [v]
    call ExitProcess
main ENDP
END
