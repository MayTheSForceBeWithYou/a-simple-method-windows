; Exercise 13: setb unsigned
;
; rax=1, rbx=2. cmp; setb al; exit 1 (below unsigned).
;
; Build: ml64 /c 13-setb-unsigned.asm && link /OUT:13-setb-unsigned.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-setb-unsigned.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 1
    mov rbx, 2
    cmp rax, rbx
    setb al
    movzx rcx, al
    call ExitProcess
main ENDP
END
