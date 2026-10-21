; Exercise 04: if else
;
; If rax>10 exit 1 else exit 2. Set rax=11.
;
; Build: ml64 /c 04-if-else.asm && link /OUT:04-if-else.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-if-else.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 11
    cmp rax, 10
    jg then_branch
    mov rcx, 2
    jmp L_done
then_branch:
    mov rcx, 1
L_done:
    call ExitProcess
main ENDP
END
