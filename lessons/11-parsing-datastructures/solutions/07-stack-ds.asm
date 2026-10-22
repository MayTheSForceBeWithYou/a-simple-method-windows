; Exercise 07: stack ds
;
; Push 1,2 pop to rdi; exit 2.
; Expected exit: 2

EXTERN ExitProcess:PROC

.data?
stk QWORD 8 DUP(?)
sp_ QWORD ?

.code

ex_07_stack_ds PROC
mov QWORD PTR [sp_], 0
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    mov QWORD PTR [r11+rcx*8], 1
    inc QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    mov QWORD PTR [r11+rcx*8], 2
    inc QWORD PTR [sp_]
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    mov rcx, QWORD PTR [r11+rcx*8]
    mov     eax, ecx
    ret
ex_07_stack_ds ENDP
main PROC
    sub     rsp, 40
    call    ex_07_stack_ds
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
