; Expected exit: 24

EXTERN ExitProcess:PROC

.code
ex_04_shl_mul PROC
    sub rsp, 40
    mov rax, 3
    shl rax, 3
        mov     eax, rax
    ret

ex_04_shl_mul ENDP
main PROC
    call    ex_04_shl_mul
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
