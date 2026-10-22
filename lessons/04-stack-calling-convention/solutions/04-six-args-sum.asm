; Exercise: 04-six-args-sum
;
; sum6(a..f): first 4 in regs, 5th and 6th on stack. Pass 1..6; exit 21.
; Expected exit: 21
;
.code
ex_04_six_args_sum PROC
    sub rsp, 56 ; 32 shadow + 16 for args 5-6
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    mov QWORD PTR [rsp+32], 5
    mov QWORD PTR [rsp+40], 6
    call sum6
    add rsp, 56
    mov     eax, eax
    ret
ex_04_six_args_sum ENDP
main PROC
    sub     rsp, 40
    call    ex_04_six_args_sum
    mov     rcx, rax
    call    ExitProcess
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
