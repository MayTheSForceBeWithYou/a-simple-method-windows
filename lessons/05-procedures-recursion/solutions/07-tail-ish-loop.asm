; Exercise 07: tail ish loop
; sum_to loop (tail form). sum_to(6)=21.
; Expected exit: 21

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 6
    call sum_to
    mov rcx, rax
    call ExitProcess
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
