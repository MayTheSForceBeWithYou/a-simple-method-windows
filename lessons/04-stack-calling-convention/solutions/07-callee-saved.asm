; Exercise 07: callee saved
;
; Caller puts 9 in rbx. Callee must preserve rbx. Exit rbx (9). (rbx is nonvolatile on Windows)
;
; Build: ml64 /c 07-callee-saved.asm && link /OUT:07-callee-saved.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-callee-saved.obj kernel32.lib
;
; Expected exit: 9

EXTERN ExitProcess:PROC

.code
ex_07_callee_saved PROC
    sub rsp, 40
    mov rbx, 9
    call clobber_careful
    mov rcx, rbx
    mov     eax, rbx
    add     rsp, 40
    ret
ex_07_callee_saved ENDP
main PROC
    sub     rsp, 40
    call    ex_07_callee_saved
    mov     rcx, rax
    call    ExitProcess
main ENDP

clobber_careful PROC
    push rbx
    mov rbx, 123
    pop rbx
    ret
clobber_careful ENDP
END
