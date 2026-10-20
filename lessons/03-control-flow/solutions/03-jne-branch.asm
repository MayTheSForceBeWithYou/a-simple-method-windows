; Exercise 03: jne branch
;
; rax=1,rbx=2. jne -> exit 5; if equal would exit 0.
;
; Build: ml64 /c 03-jne-branch.asm && link /OUT:03-jne-branch.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-jne-branch.obj kernel32.lib
;
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 1
    mov rbx, 2
    cmp rax, rbx
    jne diff
    xor rcx, rcx
    jmp exit_proc
diff:
    mov rcx, 5
exit_proc:
    call ExitProcess
main ENDP
END
