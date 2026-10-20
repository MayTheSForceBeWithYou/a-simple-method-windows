; Exercise 23: stretch memo fib slot
; Memoized fib(8)=21. Exit 21.
; Expected exit: 21

EXTERN ExitProcess:PROC

.data?
memo QWORD 16 DUP(?)

.code
main PROC
    sub rsp, 32
    mov rcx, 16
    lea r8, memo
clear_loop:
    mov QWORD PTR [r8], -1
    add r8, 8
    loop clear_loop
    mov rcx, 8
    call fibm
    mov rcx, rax
    call ExitProcess
main ENDP

fibm PROC
    cmp rcx, 1
    jle base_fibm
    cmp QWORD PTR memo[rcx*8], -1
    jne hit_fibm
    push rbx
    push rcx
    sub rsp, 32
    dec rcx
    call fibm
    add rsp, 32
    mov rbx, rax
    mov rcx, QWORD PTR [rsp+32]
    sub rcx, 2
    sub rsp, 32
    call fibm
    add rsp, 32
    add rax, rbx
    pop rcx
    pop rbx
    mov memo[rcx*8], rax
    ret
hit_fibm:
    mov rax, memo[rcx*8]
    ret
base_fibm:
    mov rax, rcx
    ret
fibm ENDP
END
