; Exercise 20: weather tick
;
; Rain intensity 0..3 cycle; from 3 -> 0; exit 0.
;
; Build: ml64 /c 20-weather-tick.asm && link /OUT:20-weather-tick.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-weather-tick.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [rain],3
    inc qword [rain]
    and qword [rain],3
    mov rcx, [rain]
    call ExitProcess

main ENDP
END
