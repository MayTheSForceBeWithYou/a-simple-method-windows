; Exercise 01: push pop
;
; push 3; push 4; pop rax; pop rcx; add rcx,rax; exit 7.
;
; Build: ml64 /c 01-push-pop.asm && link /OUT:01-push-pop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-push-pop.obj kernel32.lib
;
; Expected exit: 7

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    push 3
    push 4
    pop rax
    pop rcx
    add rcx, rax
    call ExitProcess
main ENDP
END
