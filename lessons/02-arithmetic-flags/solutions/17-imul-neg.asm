; Exercise 17: imul neg
;
; rax=-3; imul rax, -4; mov rcx,rax; exit 12.
;
; Build: ml64 /c 17-imul-neg.asm && link /OUT:17-imul-neg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-imul-neg.obj kernel32.lib
;
; Expected exit: 12

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, -3
    imul rax, -4
    mov rcx, rax
    call ExitProcess
main ENDP
END
