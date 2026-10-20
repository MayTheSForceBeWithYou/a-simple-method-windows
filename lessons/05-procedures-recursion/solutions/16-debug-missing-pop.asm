; Exercise 16: debug missing pop
; BUG fixed: balanced stack. fact(3)=6.
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 3
    call fact
    mov rcx, rax
    call ExitProcess
main ENDP

fact PROC
    cmp rcx, 1
    jle base_fact
    push rcx
    sub rsp, 32
    dec rcx
    call fact
    add rsp, 32
    pop rcx
    imul rax, rcx
    ret
base_fact:
    mov rax, 1
    ret
fact ENDP
END
