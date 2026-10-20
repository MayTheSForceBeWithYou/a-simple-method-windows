; Exercise 06: ride open
;
; flag open=1; exit 1.
;
; Build: ml64 /c 06-ride-open.asm && link /OUT:06-ride-open.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-ride-open.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
open BYTE ?

.code
main PROC
    sub rsp, 32
    mov BYTE PTR [open], 1
    movzx rcx, BYTE PTR [open]
    call ExitProcess
main ENDP
END
