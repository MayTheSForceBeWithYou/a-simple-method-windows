; Exercise 13: peep pathfind step
;
; Peep follows path; steps remaining 4; exit 4.
;
; Build: ml64 /c 13-peep-pathfind-step.asm && link /OUT:13-peep-pathfind-step.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-peep-pathfind-step.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [steps],4
    mov rcx, [steps]
    call ExitProcess

main ENDP
END
