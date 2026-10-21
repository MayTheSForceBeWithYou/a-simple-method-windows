; Exercise 21: min via cmovl
;
; Same with 17 and 23; min into rcx (17) using cmovl.
;
; Build: ml64 /c 21-min-via-cmovl.asm && link /OUT:21-min-via-cmovl.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-min-via-cmovl.obj kernel32.lib
;
; Expected exit: 17

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 17
    mov rbx, 23
    mov rcx, rax
    cmp rbx, rcx
    cmovl rcx, rbx
    call ExitProcess
main ENDP
END
