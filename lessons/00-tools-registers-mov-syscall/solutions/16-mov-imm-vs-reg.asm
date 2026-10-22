; Exercise: 16-mov-imm-vs-reg
;
; Load 100 into rax (imm), copy to rbx, copy rbx to rcx, exit.
; Expected exit: 100
;
.code
ex_16_mov_imm_vs_reg PROC
    sub rsp, 40
    mov rax, 100
    mov rbx, rax
    mov rcx, rbx
    mov     eax, ebx
    add     rsp, 40
    ret
ex_16_mov_imm_vs_reg ENDP
main PROC
    sub     rsp, 40
    call    ex_16_mov_imm_vs_reg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
