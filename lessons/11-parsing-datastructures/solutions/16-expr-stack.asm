; Exercise 16: expr stack
;
; Shunting: push 2,3, add -> 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.data?
stk QWORD 8 DUP(?)
sp_ QWORD ?

.code

ex_16_expr_stack PROC
sub rsp, 40
    mov QWORD PTR [sp_], 0
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    mov QWORD PTR [r11+rcx*8], 2
    inc QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    mov QWORD PTR [r11+rcx*8], 3
    inc QWORD PTR [sp_]
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    mov rax, QWORD PTR [r11+rcx*8]
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    add rax, QWORD PTR [r11+rcx*8]
    lea r11, [stk]
    mov QWORD PTR [r11+rcx*8], rax
    inc QWORD PTR [sp_]
    mov     eax, 5
    ret
ex_16_expr_stack ENDP
main PROC
    sub     rsp, 40
    call    ex_16_expr_stack
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
