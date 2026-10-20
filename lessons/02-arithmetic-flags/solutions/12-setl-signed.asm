; Exercise 12: setl signed
;
; rax=-1 (or 0xffffffffffffffff), rbx=0. cmp rax,rbx; setl al; exit 1.
;
; Build: ml64 /c 12-setl-signed.asm && link /OUT:12-setl-signed.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-setl-signed.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, -1
    mov rbx, 0
    cmp rax, rbx
    setl al
    movzx rcx, al
    call ExitProcess
main ENDP
END
