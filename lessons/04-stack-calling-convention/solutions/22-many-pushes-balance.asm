; Exercise 22: many pushes balance
;
; Push 1,2,3; call sum_top3 that reads [rsp+8],[rsp+16],[rsp+24] after call. Exit 6.
;
; Expected exit: 6
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_22_many_pushes_balance PROC
    push 1
    push 2
    push 3
    call sum_top3
    add rsp, 24
    mov rcx, rax
    sub rsp, 40
    mov     eax, ecx
    add     rsp, 40
    ret
ex_22_many_pushes_balance ENDP
main PROC
    sub     rsp, 40
    call    ex_22_many_pushes_balance
    mov     rcx, rax
    call    ExitProcess
main ENDP

sum_top3 PROC
    mov rax, QWORD PTR [rsp+8]
    add rax, QWORD PTR [rsp+16]
    add rax, QWORD PTR [rsp+24]
    ret
sum_top3 ENDP
END
