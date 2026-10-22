; Expected exit: 15

EXTERN ExitProcess:PROC

.code

ex_01_and_mask PROC
mov rax, 0FFh
    and rax, 0Fh
    mov rcx, rax

    ret
ex_01_and_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_01_and_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
