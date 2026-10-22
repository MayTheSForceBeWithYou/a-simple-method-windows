; Exercise: 05-sar-sign
;
; Expected exit: 252
;
.code
ex_05_sar_sign PROC
    sub rsp, 40
    mov rax, -8
    sar rax, 1
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_sar_sign ENDP
main PROC
    sub     rsp, 40
    call    ex_05_sar_sign
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
