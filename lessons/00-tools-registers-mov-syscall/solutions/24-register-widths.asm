; Exercise 24: register widths
;
; rax=01111222233334444h; mov ax,0ABCDh; exit with movzx rcx,al (205).
;
; Build: ml64 /c 24-register-widths.asm && link /OUT:24-register-widths.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-register-widths.obj kernel32.lib
;
; Expected exit: 205

EXTERN ExitProcess:PROC

.code
ex_24_register_widths PROC
    sub rsp, 40
    mov rax, 01111222233334444h
    mov ax, 0ABCDh
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_24_register_widths ENDP
main PROC
    sub     rsp, 40
    call    ex_24_register_widths
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
