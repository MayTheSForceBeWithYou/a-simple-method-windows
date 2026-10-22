; Expected exit: 4

EXTERN ExitProcess:PROC

.code
ex_11_isolate_lowbit PROC
    sub rsp, 40
    mov rax, 101100b
    mov rbx, rax
    neg rbx
    and rax, rbx
    mov rcx, rax
        mov     eax, 60
    add     rsp, 40
    ret
ex_11_isolate_lowbit ENDP
main PROC
    sub     rsp, 40
    call    ex_11_isolate_lowbit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
