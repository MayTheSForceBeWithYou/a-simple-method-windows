; Expected exit: 4

EXTERN ExitProcess:PROC

.code

ex_21_gray_code PROC
mov rax, 7
    mov rbx, rax
    shr rbx, 1
    xor rax, rbx
    mov rcx, rax
    mov rax,60
    ret
ex_21_gray_code ENDP
main PROC
    sub     rsp, 40
    call    ex_21_gray_code
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
