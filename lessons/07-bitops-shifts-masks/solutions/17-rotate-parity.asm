; Exercise: 17-rotate-parity
;
; Expected exit: 128
;
.code
ex_17_rotate_parity PROC
    sub rsp, 40
    mov al, 01h
    ror al, 1
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_17_rotate_parity ENDP
main PROC
    sub     rsp, 40
    call    ex_17_rotate_parity
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
