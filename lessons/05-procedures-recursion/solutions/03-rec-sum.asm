; Exercise 03: rec sum
; sum_to(n)=n+(n-1)+...+1 recursive. sum_to(5)=15.
; Expected exit: 15

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 5
    call sum_to
    mov rcx, rax
    call ExitProcess
main ENDP

sum_to PROC
    cmp rcx, 0
    jle zero_sum
    push rcx
    sub rsp, 40
    dec rcx
    call sum_to
    add rsp, 40
    pop rcx
    add rax, rcx
    ret
zero_sum:
    xor rax, rax
    ret
sum_to ENDP
END
