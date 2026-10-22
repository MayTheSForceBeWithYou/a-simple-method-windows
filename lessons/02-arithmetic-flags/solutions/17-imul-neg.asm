; Exercise: 17-imul-neg
;
; rax=-3; imul rax, -4; mov rcx,rax; exit 12.
; Expected exit: 12
;
.code
ex_17_imul_neg PROC
    sub rsp, 40
    mov rax, -3
    imul rax, -4
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_17_imul_neg ENDP
main PROC
    sub     rsp, 40
    call    ex_17_imul_neg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
