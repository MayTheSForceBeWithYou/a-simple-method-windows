; Exercise 05: entity alive
;
; flags bit0 alive; exit 1.
;
; Build: ml64 /c 05-entity-alive.asm && link /OUT:05-entity-alive.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-entity-alive.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
flags BYTE 1

.code
main PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [flags]
    and rcx, 1
    call ExitProcess
main ENDP
END
