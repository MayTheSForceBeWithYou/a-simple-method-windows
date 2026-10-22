; Exercise 07: idiv setup
;
; Divide 84 by 2 using idiv. cqo; idiv. Exit with quotient in rcx.
;
; Build: ml64 /c 07-idiv-setup.asm && link /OUT:07-idiv-setup.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-idiv-setup.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code

ex_07_idiv_setup PROC
mov rax, 84
    cqo
    mov rbx, 2
    idiv rbx
    mov rcx, rax
    ret
ex_07_idiv_setup ENDP
main PROC
    sub     rsp, 40
    call    ex_07_idiv_setup
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
