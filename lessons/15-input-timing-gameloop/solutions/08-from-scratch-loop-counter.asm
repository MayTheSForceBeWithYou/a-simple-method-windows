; Exercise 08: from scratch loop counter
;
; FROM SCRATCH: 10 frame iterations; exit 10.
;
; Build: ml64 /c 08-from-scratch-loop-counter.asm && link /OUT:08-from-scratch-loop-counter.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-loop-counter.obj kernel32.lib
;
; Expected exit: 10
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
loop_start:
    cmp rcx, 10
    jge loop_done
    inc rcx
    jmp loop_start
loop_done:
    call ExitProcess
main ENDP
END
