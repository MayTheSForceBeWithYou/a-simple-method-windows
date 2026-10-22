; Exercise 10: cmp setne
;
; rax=5, rbx=6. setne -> exit 1.
;
; Build: ml64 /c 10-cmp-setne.asm && link /OUT:10-cmp-setne.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-cmp-setne.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_10_cmp_setne PROC
    sub rsp, 40
    mov rax, 5
    mov rbx, 6
    cmp rax, rbx
    setne al
    movzx rcx, al
    mov     eax, 1
    add     rsp, 40
    ret
ex_10_cmp_setne ENDP
main PROC
    call    ex_10_cmp_setne
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
