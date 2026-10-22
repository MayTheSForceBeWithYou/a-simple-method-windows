; Exercise 16: clamp q
;
; Clamp -3 to [0,100]; exit 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_16_clamp_q PROC
    sub rsp, 40
    mov rax, -3
    cmp rax, 0
    jge clamp_hi
    xor rax, rax
clamp_hi:
    cmp rax, 100
    jle clamp_ok
    mov rax, 100
clamp_ok:
        add     rsp, 40
        ret
ex_16_clamp_q ENDP
main PROC
    sub     rsp, 40
    call    ex_16_clamp_q
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
