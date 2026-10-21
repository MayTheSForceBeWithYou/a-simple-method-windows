; Exercise 06: path step
;
; Follow next cell delta x+1; exit 1.
;
; Build: ml64 /c 06-path-step.asm && link /OUT:06-path-step.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-path-step.obj kernel32.lib
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
