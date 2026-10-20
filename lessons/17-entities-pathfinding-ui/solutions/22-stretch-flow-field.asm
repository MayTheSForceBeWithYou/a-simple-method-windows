; Exercise 22: stretch flow field
;
; STRETCH: flow cell cost 4; exit 4.
;
; Build: ml64 /c 22-stretch-flow-field.asm && link /OUT:22-stretch-flow-field.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-flow-field.obj kernel32.lib
;
; Expected exit: 4
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rcx, 4
    call ExitProcess

main ENDP
END
