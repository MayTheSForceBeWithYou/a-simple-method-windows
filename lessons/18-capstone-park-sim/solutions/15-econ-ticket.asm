; Exercise 15: econ ticket
;
; cash += ticket 15; from 0 exit 15.
;
; Build: ml64 /c 15-econ-ticket.asm && link /OUT:15-econ-ticket.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-econ-ticket.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    add qword [cash],15
    mov rcx, [cash]
    call ExitProcess

main ENDP
END
