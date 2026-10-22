; Exercise 12: setl signed
;
; rax=-1 (or 0FFFFFFFFFFFFFFFFh), rbx=0. cmp rax,rbx; setl al; exit 1.
;
; Build: ml64 /c 12-setl-signed.asm && link /OUT:12-setl-signed.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-setl-signed.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_12_setl_signed PROC
    sub rsp, 40
    mov rax, -1
    mov rbx, 0
    cmp rax, rbx
    setl al
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_12_setl_signed ENDP
main PROC
    sub     rsp, 40
    call    ex_12_setl_signed
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
