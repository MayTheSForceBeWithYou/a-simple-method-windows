; Exercise 21: rec binary digits
; popcount(0b1101)=3 via recursion. Exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code

ex_21_rec_binary_digits PROC
mov rcx, 1101b
    call poprec
    mov rcx, rax
    mov     eax, ecx
    ret
ex_21_rec_binary_digits ENDP
main PROC
    sub     rsp, 40
    call    ex_21_rec_binary_digits
    mov     rcx, rax
    call    ExitProcess
main ENDP

poprec PROC
    test rcx, rcx
    jz zero_pop
    push rcx
    sub rsp, 40
    mov rax, rcx
    dec rax
    and rcx, rax
    call poprec
    add rsp, 40
    pop rcx
    inc rax
    ret
zero_pop:
    xor rax, rax
    ret
poprec ENDP
END
