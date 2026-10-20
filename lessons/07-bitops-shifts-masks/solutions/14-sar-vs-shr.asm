; Exercise 14: sar vs shr
; For -4: sar 1 vs shr 1; exit (sar_result == -2) as 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, -4
    sar rax, 1
    cmp rax, -2
    sete cl
    movzx rcx, cl
    call ExitProcess
main ENDP
END
