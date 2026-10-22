; Exercise: 16-sum-1-to-n-unroll
;
; Without jumps: sum 1+2+...+8 into rcx (36) using add chain; exit.
; Expected exit: 36
;
.code
ex_16_sum_1_to_n_unroll PROC
    sub rsp, 40
    xor rcx, rcx
    add rcx, 1
    add rcx, 2
    add rcx, 3
    add rcx, 4
    add rcx, 5
    add rcx, 6
    add rcx, 7
    add rcx, 8
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_sum_1_to_n_unroll ENDP
main PROC
    sub     rsp, 40
    call    ex_16_sum_1_to_n_unroll
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
