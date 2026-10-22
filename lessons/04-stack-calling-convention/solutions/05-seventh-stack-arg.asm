; Exercise 05: seventh stack arg
;
; sum7 uses 7th arg on stack. Pass 1..7; exit 28.
;
; Build: ml64 /c 05-seventh-stack-arg.asm && link /OUT:05-seventh-stack-arg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-seventh-stack-arg.obj kernel32.lib
;
; Expected exit: 28

EXTERN ExitProcess:PROC

.code
ex_05_seventh_stack_arg PROC
    sub rsp, 56        ; 32 shadow + 24 (16 for args 5-6, 8 for arg 7, round to 16)
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    mov QWORD PTR [rsp+32], 5
    mov QWORD PTR [rsp+40], 6
    mov QWORD PTR [rsp+48], 7
    call sum7
    add rsp, 56
    mov rcx, rax
    sub rsp, 40
    mov     eax, ecx
    ret
ex_05_seventh_stack_arg ENDP
main PROC
    sub     rsp, 40
    call    ex_05_seventh_stack_arg
    mov     rcx, rax
    call    ExitProcess
main ENDP

sum7 PROC
    mov rax, rcx
    add rax, rdx
    add rax, r8
    add rax, r9
    add rax, QWORD PTR [rsp+40]
    add rax, QWORD PTR [rsp+48]
    add rax, QWORD PTR [rsp+56]
    ret
sum7 ENDP
END
