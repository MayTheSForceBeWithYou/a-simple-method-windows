; Expected exit: 24

EXTERN ExitProcess:PROC

.code

ex_04_shl_mul PROC
mov rax, 3
    shl rax, 3
    mov rcx, rax
    ; return value already in EAX/RAX
    ret
ex_04_shl_mul ENDP
main PROC
    sub     rsp, 40
    call    ex_04_shl_mul
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
