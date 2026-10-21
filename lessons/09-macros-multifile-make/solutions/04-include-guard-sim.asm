; Exercise 04: include guard sim
;
; Use IFNDEF/ENDIF for ANSWER equ 42; exit 42.
;
; Build: ml64 /c 04-include-guard-sim.asm && link /OUT:04-include-guard-sim.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-include-guard-sim.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

; MASM conditional assembly with IFNDEF
IFNDEF ANSWER
ANSWER EQU 42
ENDIF

.code
main PROC
    sub rsp, 40
    mov rcx, ANSWER
    call ExitProcess
main ENDP
END
