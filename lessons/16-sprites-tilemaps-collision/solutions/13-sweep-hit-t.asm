; Exercise 13: sweep hit t
;
; TOI stub t=3; exit 3.
;
; Build: ml64 /c 13-sweep-hit-t.asm && link /OUT:13-sweep-hit-t.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-sweep-hit-t.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 3
    call ExitProcess
main ENDP
END
