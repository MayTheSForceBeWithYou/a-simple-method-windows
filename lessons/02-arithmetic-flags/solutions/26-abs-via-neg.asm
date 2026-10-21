; Exercise 26: abs via neg
;
; rax=-42. Absolute value via neg. Exit 42.
;
; Build: ml64 /c 26-abs-via-neg.asm && link /OUT:26-abs-via-neg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-abs-via-neg.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, -42
    mov rcx, rax
    neg rcx
    call ExitProcess
main ENDP
END
