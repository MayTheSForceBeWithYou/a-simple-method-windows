; Expected exit: 171

EXTERN ExitProcess:PROC

.code
ex_13_shl_shl_combine PROC
    sub rsp, 40
    mov rax, 0Ah
    shl rax, 4
    or rax, 0Bh
    mov rcx, rax
        mov     eax, 60
    add     rsp, 40
    ret
ex_13_shl_shl_combine ENDP
main PROC
    sub     rsp, 40
    call    ex_13_shl_shl_combine
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
