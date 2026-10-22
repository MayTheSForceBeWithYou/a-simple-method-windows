; Exercise: 04-shl-mul
;
; Expected exit: 24
;
.code
ex_04_shl_mul PROC
    sub rsp, 40
    mov rax, 3
    shl rax, 3
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_04_shl_mul ENDP
main PROC
    sub     rsp, 40
    call    ex_04_shl_mul
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
