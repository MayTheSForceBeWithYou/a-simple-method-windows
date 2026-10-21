; Exercise 04: agent step
;
; agent x++; exit x.
;
; Build: ml64 /c 04-agent-step.asm && link /OUT:04-agent-step.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-agent-step.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
ax_ QWORD ?

.code
main PROC
    sub rsp, 40
    inc QWORD PTR [ax_]
    mov rcx, [ax_]
    call ExitProcess
main ENDP
END
