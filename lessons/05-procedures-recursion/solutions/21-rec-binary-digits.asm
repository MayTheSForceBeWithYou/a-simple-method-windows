; Exercise 21: rec binary digits
; popcount(0b1101)=3 via recursion. Exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 1101b
    call poprec
    mov rcx, rax
    call ExitProcess
main ENDP

poprec PROC
    test rcx, rcx
    jz zero_pop
    push rcx
    sub rsp, 32
    mov rax, rcx
    dec rax
    and rcx, rax
    call poprec
    add rsp, 32
    pop rcx
    inc rax
    ret
zero_pop:
    xor rax, rax
    ret
poprec ENDP
END
