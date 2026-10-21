; Exercise 16: include path sim
;
; Define VERSION 3; exit VERSION.
;
; Build: ml64 /c 16-include-path-sim.asm && link /OUT:16-include-path-sim.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-include-path-sim.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

; Define constant
VERSION EQU 3

.code
main PROC
    sub rsp, 40
    mov rcx, VERSION
    call ExitProcess
main ENDP
END
