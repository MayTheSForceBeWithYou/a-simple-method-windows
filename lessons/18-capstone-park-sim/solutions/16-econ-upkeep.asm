; Exercise 16: econ upkeep
;
; cash -= 3; from 10 exit 7.
;
; Build: ml64 /c 16-econ-upkeep.asm && link /OUT:16-econ-upkeep.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-econ-upkeep.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [cash],10
    sub qword [cash],3
    mov rcx, [cash]
    call ExitProcess

main ENDP
END
