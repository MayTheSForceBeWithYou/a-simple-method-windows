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
ex_17_flip_flags PROC
    sub rsp, 40
    mov rcx, HFLIP
    or rcx, VFLIP
    mov     eax, 3
    ret
ex_17_flip_flags ENDP
main PROC
    call    ex_17_flip_flags
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
