; Exercise 24: register widths
;
; rax=0x1111222233334444; mov ax,0xABCD; exit with movzx rcx,al (205).
;
; Build: ml64 /c 24-register-widths.asm && link /OUT:24-register-widths.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-register-widths.obj kernel32.lib
;
; Expected exit: 205

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 01111222233334444h
    mov ax, 0ABCDh
    movzx rcx, al
    call ExitProcess
main ENDP
END
