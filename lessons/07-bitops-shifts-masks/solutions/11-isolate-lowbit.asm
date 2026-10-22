; Expected exit: 4

EXTERN ExitProcess:PROC

.code

ex_11_isolate_lowbit PROC
mov rax, 101100b
    mov rbx, rax
    neg rbx
    and rax, rbx
    mov rcx, rax
    mov rax,60
    ret
ex_11_isolate_lowbit ENDP
main PROC
    sub     rsp, 40
    call    ex_11_isolate_lowbit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
