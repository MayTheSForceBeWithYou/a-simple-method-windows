; Exercise 01: push pop
;
; push 3; push 4; pop rax; pop rcx; add rcx,rax; exit 7.
;
; Build: ml64 /c 01-push-pop.asm && link /OUT:01-push-pop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-push-pop.obj kernel32.lib
;
; Expected exit: 7

EXTERN ExitProcess:PROC

.code
ex_01_push_pop PROC
    sub rsp, 40
    push 3
    push 4
    pop rax
    pop rcx
    add rcx, rax
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_push_pop ENDP
main PROC
    sub     rsp, 40
    call    ex_01_push_pop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
