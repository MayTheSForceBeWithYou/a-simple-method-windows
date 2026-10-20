; Exercise 04: six args sum
;
; sum6(a..f): first 4 in regs, 5th and 6th on stack. Pass 1..6; exit 21.
;
; Build: ml64 /c 04-six-args-sum.asm && link /OUT:04-six-args-sum.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-six-args-sum.obj kernel32.lib
;
; Expected exit: 21

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 48        ; 32 shadow + 16 for args 5-6
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    mov QWORD PTR [rsp+32], 5
    mov QWORD PTR [rsp+40], 6
    call sum6
    add rsp, 48
    mov rcx, rax
    sub rsp, 32
    call ExitProcess
main ENDP

sum6 PROC
    mov rax, rcx
    add rax, rdx
    add rax, r8
    add rax, r9
    add rax, QWORD PTR [rsp+40]
    add rax, QWORD PTR [rsp+48]
    ret
sum6 ENDP
END
