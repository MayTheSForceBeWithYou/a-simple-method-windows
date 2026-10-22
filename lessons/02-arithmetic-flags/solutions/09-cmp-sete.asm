; Exercise 09: cmp sete
;
; rax=5, rbx=5. cmp; sete al; movzx rcx,al; exit 1.
;
; Build: ml64 /c 09-cmp-sete.asm && link /OUT:09-cmp-sete.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-cmp-sete.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_09_cmp_sete PROC
    sub rsp, 40
    mov rax, 5
    mov rbx, 5
    cmp rax, rbx
    sete al
    movzx rcx, al
    mov     eax, 1
    ret
    add     rsp, 40
ex_09_cmp_sete ENDP
main PROC
    call    ex_09_cmp_sete
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
