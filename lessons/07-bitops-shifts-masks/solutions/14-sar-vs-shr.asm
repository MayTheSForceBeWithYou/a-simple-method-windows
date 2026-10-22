; Exercise 14: sar vs shr
; For -4: sar 1 vs shr 1; exit (sar_result == -2) as 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code

ex_14_sar_vs_shr PROC
mov rax, -4
    sar rax, 1
    cmp rax, -2
    sete cl
    movzx rcx, cl
    ret
ex_14_sar_vs_shr ENDP
main PROC
    sub     rsp, 40
    call    ex_14_sar_vs_shr
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
