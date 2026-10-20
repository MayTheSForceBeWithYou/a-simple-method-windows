; Exercise 14: ride queue len
;
; Queue length 7; exit 7.
;
; Build: ml64 /c 14-ride-queue-len.asm && link /OUT:14-ride-queue-len.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-ride-queue-len.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [qlen],7
    mov rcx, [qlen]
    call ExitProcess

main ENDP
END
