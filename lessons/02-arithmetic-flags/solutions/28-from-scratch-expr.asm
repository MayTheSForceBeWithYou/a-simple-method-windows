; Exercise 28: from scratch expr
;
; FROM SCRATCH: exit status = (12*12 - 100) / 4 + 1 = 12. Show work with idiv.
;
; Build: ml64 /c 28-from-scratch-expr.asm && link /OUT:28-from-scratch-expr.exe /ENTRY:main /SUBSYSTEM:CONSOLE 28-from-scratch-expr.obj kernel32.lib
;
; Expected exit: 12

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 12
    imul rax, 12
    sub rax, 100
    cqo
    mov rbx, 4
    idiv rbx
    add rax, 1
    mov rcx, rax
    call ExitProcess
main ENDP
END
