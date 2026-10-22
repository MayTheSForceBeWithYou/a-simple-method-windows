; Exercise 23: stretch memo fib slot
; Memoized fib(8)=21. Exit 21.
; Expected exit: 21

EXTERN ExitProcess:PROC

.data?
memo QWORD 16 DUP(?)

.code

ex_23_stretch_memo_fib_slot PROC
mov rcx, 16
    lea r8, [memo]
clear_loop:
    mov QWORD PTR [r8], -1
    add r8, 8
    loop clear_loop
    mov rcx, 8
    call fibm
    mov rcx, rax
    mov     eax, rax
    ret
ex_23_stretch_memo_fib_slot ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_memo_fib_slot
    mov     rcx, rax
    call    ExitProcess
main ENDP

fibm PROC
    cmp rcx, 1
    jle base_fibm
    lea r11, [memo]
    cmp QWORD PTR [r11+rcx*8], -1
    jne hit_fibm
    push rbx
    push rcx
    sub rsp, 40
    dec rcx
    call fibm
    mov rbx, rax
    mov rcx, QWORD PTR [rsp+40]
    sub rcx, 2
    call fibm
    add rax, rbx
    add rsp, 40
    pop rcx
    pop rbx
    lea r11, [memo]
    mov QWORD PTR [r11+rcx*8], rax
    ret
hit_fibm:
    lea r11, [memo]
    mov rax, QWORD PTR [r11+rcx*8]
    ret
base_fibm:
    mov rax, rcx
    ret
fibm ENDP
END
