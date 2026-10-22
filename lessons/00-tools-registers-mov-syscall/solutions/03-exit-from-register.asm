; Exercise 03: exit from register
;
; Put 42 in rbx, copy to rcx, exit with that status. Immediate only allowed when loading rbx.
;
; Build: ml64 /c 03-exit-from-register.asm && link /OUT:03-exit-from-register.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-exit-from-register.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code

ex_03_exit_from_register PROC
mov rbx, 42
    mov rcx, rbx
    mov     eax, ecx
    ret
ex_03_exit_from_register ENDP
main PROC
    sub     rsp, 40
    call    ex_03_exit_from_register
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
