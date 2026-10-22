; Exercise: 19-debug-sign-shift
;
; Expected exit: 252
;
.code
ex_19_debug_sign_shift PROC
    sub rsp, 40
    mov rax, -16
    sar rax, 2
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_19_debug_sign_shift ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_sign_shift
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
