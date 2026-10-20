; Exercise 24: from scratch sim integrate
;
; FROM SCRATCH: one tick: place path, peep step, cash+=1; exit cash 1.
;
; Build: ml64 /c 24-from-scratch-sim-integrate.asm && link /OUT:24-from-scratch-sim-integrate.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-sim-integrate.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov byte [map],1
    inc qword [peep_x]
    inc qword [cash]
    mov rcx, [cash]
    call ExitProcess

main ENDP
END
