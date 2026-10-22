; Expected exit: 31

EXTERN ExitProcess:PROC

.code

ex_18_mask_range PROC
mov rax, 1
    shl rax, 5
    dec rax
    mov rcx, rax
    mov rax,60

    ret
ex_18_mask_range ENDP
main PROC
    sub     rsp, 40
    call    ex_18_mask_range
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
