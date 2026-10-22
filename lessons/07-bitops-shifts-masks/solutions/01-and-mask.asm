; Expected exit: 15

EXTERN ExitProcess:PROC

.code
ex_01_and_mask PROC
    sub rsp, 40
    mov rax, 0FFh
    and rax, 0Fh
        mov     eax, ecx
    add     rsp, 40
    ret
ex_01_and_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_01_and_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
