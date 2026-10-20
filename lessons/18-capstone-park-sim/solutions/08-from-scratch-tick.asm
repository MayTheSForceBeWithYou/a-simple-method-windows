; Exercise 08: from scratch tick
;
; FROM SCRATCH: sim_tick counter to 5; exit 5.
;
; Build: ml64 /c 08-from-scratch-tick.asm && link /OUT:08-from-scratch-tick.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-tick.obj kernel32.lib
;
; Expected exit: 5
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
tick QWORD ?

.code
main PROC
    sub rsp, 32
tick_loop:
    cmp QWORD PTR [tick], 5
    jge tick_done
    inc QWORD PTR [tick]
    jmp tick_loop
tick_done:
    mov rcx, [tick]
    call ExitProcess
main ENDP
END
