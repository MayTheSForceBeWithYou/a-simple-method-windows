; Exercise 09: fib iter proc
; Iterative fib(10)=55.
; Expected exit: 55

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 10
    call fib
    mov rcx, rax
    call ExitProcess
main ENDP

fib PROC
    cmp rcx, 0
    je zero_fib
    cmp rcx, 1
    je one_fib
    push rbx
    mov rax, 0
    mov rbx, 1
    mov r8, 2
loop_fib:
    cmp r8, rcx
    jg done_fib
    mov rdx, rax
    add rdx, rbx
    mov rax, rbx
    mov rbx, rdx
    inc r8
    jmp loop_fib
done_fib:
    mov rax, rbx
    pop rbx
    ret
zero_fib:
    xor rax, rax
    ret
one_fib:
    mov rax, 1
    ret
fib ENDP
END
