; Exercise: 22-euler-multiples-unroll
;
; Project-Euler-lite: sum of multiples of 3 or 5 below 20 (unrolled/constant). Answer 78. Exit 78.
; Expected exit: 78
;
.code
ex_22_euler_multiples_unroll PROC
    sub rsp, 40
    mov rcx, 78
    mov     eax, 78
    add     rsp, 40
    ret
ex_22_euler_multiples_unroll ENDP
main PROC
    sub     rsp, 40
    call    ex_22_euler_multiples_unroll
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
