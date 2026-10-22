; Exercise: 28-from-scratch-expr
;
; FROM SCRATCH: exit status = (12*12 - 100) / 4 + 1 = 12. Show work with idiv.
; Expected exit: 12
;
.code
ex_28_from_scratch_expr PROC
    sub rsp, 40
    mov rax, 12
    imul rax, 12
    sub rax, 100
    cqo
    mov rbx, 4
    idiv rbx
    add rax, 1
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_28_from_scratch_expr ENDP
main PROC
    sub     rsp, 40
    call    ex_28_from_scratch_expr
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
