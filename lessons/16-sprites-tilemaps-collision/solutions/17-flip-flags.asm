; Exercise 17: flip flags
;
; HFLIP|VFLIP = 3; exit 3.
;
; Build: ml64 /c 17-flip-flags.asm && link /OUT:17-flip-flags.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-flip-flags.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

HFLIP EQU 1
VFLIP EQU 2

.code
main PROC
    sub rsp, 40
    mov rcx, HFLIP
    or rcx, VFLIP
    call ExitProcess
main ENDP
END
