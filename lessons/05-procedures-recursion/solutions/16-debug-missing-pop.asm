; Exercise 16: debug missing pop
; BUG fixed: balanced stack. fact(3)=6.
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
ex_16_debug_missing_pop PROC
    sub rsp, 40
    mov rcx, 3
    call fact
        mov     eax, rax
    ret

ex_16_debug_missing_pop ENDP
main PROC
    call    ex_16_debug_missing_pop
    mov     rcx, rax
    call    ExitProcess
main ENDP

fact PROC
    cmp rcx, 1
    jle base_fact
    push rcx
    sub rsp, 40
    dec rcx
    call fact
    add rsp, 40
    pop rcx
    imul rax, rcx
    ret
base_fact:
    mov rax, 1
    ret
fact ENDP
END
