; Exercise 07: tail ish loop
; sum_to loop (tail form). sum_to(6)=21.
; Expected exit: 21

EXTERN ExitProcess:PROC

.code
ex_07_tail_ish_loop PROC
    sub rsp, 40
    mov rcx, 6
    call sum_to
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_07_tail_ish_loop ENDP
main PROC
    sub     rsp, 40
    call    ex_07_tail_ish_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP

sum_to PROC
    xor rax, rax
loop_start:
    cmp rcx, 0
    jle loop_done
    add rax, rcx
    dec rcx
    jmp loop_start
loop_done:
    ret
sum_to ENDP
END
