; Exercise: 15-exit-sum
;
; Set r8=10, r9=20, r10=12. Sum into rcx; exit (42).
; Expected exit: 42
;
.code
ex_15_exit_sum PROC
    sub rsp, 40
    mov r8, 10
    mov r9, 20
    mov r10, 12
    mov rcx, r8
    add rcx, r9
    add rcx, r10
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_exit_sum ENDP
main PROC
    sub     rsp, 40
    call    ex_15_exit_sum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
