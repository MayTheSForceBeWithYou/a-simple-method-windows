; Expected exit: 2

EXTERN ExitProcess:PROC

.code
ex_03_xor_swap PROC
    sub rsp, 40
    mov rax, 1
    mov rbx, 2
    xor rax, rbx
    xor rbx, rax
    xor rax, rbx
        mov     eax, ecx
    add     rsp, 40
    ret
ex_03_xor_swap ENDP
main PROC
    sub     rsp, 40
    call    ex_03_xor_swap
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
