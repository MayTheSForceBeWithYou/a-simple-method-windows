; Exercise: 30-signed-vs-unsigned-jmp
;
; rax=0FFFFFFFFFFFFFFFFh (-1 signed), cmp to 1. Using jl should take less path exit 1; document why ja would not.
; Expected exit: 1
;
.code
ex_30_signed_vs_unsigned_jmp PROC
    sub rsp, 40
    mov rax, -1
    cmp rax, 1
    jl less
    mov rcx, 0
    jmp L_done
less:
    mov rcx, 1
L_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_30_signed_vs_unsigned_jmp ENDP
main PROC
    sub     rsp, 40
    call    ex_30_signed_vs_unsigned_jmp
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
