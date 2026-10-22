; Exercise: 26-abs-via-neg
;
; rax=-42. Absolute value via neg. Exit 42.
; Expected exit: 42
;
.code
ex_26_abs_via_neg PROC
    sub rsp, 40
    mov rax, -42
    mov rcx, rax
    neg rcx
    mov     eax, ecx
    add     rsp, 40
    ret
ex_26_abs_via_neg ENDP
main PROC
    sub     rsp, 40
    call    ex_26_abs_via_neg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
