; Exercise 24: register widths
;
; rax=01111222233334444h; mov ax,0ABCDh; exit with movzx rcx,al (205).
;
; Build: ml64 /c 24-register-widths.asm && link /OUT:24-register-widths.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-register-widths.obj kernel32.lib
;
; Expected exit: 205


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_24_register_widths:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_register_widths in this file.
    call    ex_24_register_widths
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
