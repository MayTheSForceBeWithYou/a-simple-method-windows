; Exercise: 10-cmp-setne
;
; rax=5, rbx=6. setne -> exit 1.
; Expected exit: 1
;
.code
ex_10_cmp_setne PROC
    sub rsp, 40
    mov rax, 5
    mov rbx, 6
    cmp rax, rbx
    setne al
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_10_cmp_setne ENDP
main PROC
    sub     rsp, 40
    call    ex_10_cmp_setne
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
