; Exercise 10: nested if
;
; rax=7. If rax>0 and rax<10 exit 1 else 0.
;
; Build: ml64 /c 10-nested-if.asm && link /OUT:10-nested-if.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-nested-if.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 7
    cmp rax, 0
    jle no
    cmp rax, 10
    jge no
    mov rcx, 1
    jmp L_done
no:
    xor rcx, rcx
L_done:
    call ExitProcess
main ENDP
END
