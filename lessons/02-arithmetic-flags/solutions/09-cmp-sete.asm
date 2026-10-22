; Exercise: 09-cmp-sete
;
; rax=5, rbx=5. cmp; sete al; movzx rcx,al; exit 1.
; Expected exit: 1
;
.code
ex_09_cmp_sete PROC
    sub rsp, 40
    mov rax, 5
    mov rbx, 5
    cmp rax, rbx
    sete al
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_09_cmp_sete ENDP
main PROC
    sub     rsp, 40
    call    ex_09_cmp_sete
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
