; Exercise 12: recursion fib
; Naive fib(7)=13. MS x64 ABI.
; Expected exit: 13

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 7
    call fib
    mov rcx, rax
    call ExitProcess
main ENDP

fib PROC
    cmp rcx, 1
    jle base_case
    push rcx
    sub rsp, 40
    dec rcx
    call fib
    add rsp, 40
    pop rcx
    push rax
    sub rsp, 40
    sub rcx, 2
    call fib
    add rsp, 40
    pop rdx
    add rax, rdx
    ret
base_case:
    mov rax, rcx
    ret
fib ENDP
END
