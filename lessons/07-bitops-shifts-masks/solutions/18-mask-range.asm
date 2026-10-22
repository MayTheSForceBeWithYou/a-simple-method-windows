; Exercise: 18-mask-range
;
; Expected exit: 31
;
.code
ex_18_mask_range PROC
    sub rsp, 40
    mov rax, 1
    shl rax, 5
    dec rax
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_18_mask_range ENDP
main PROC
    sub     rsp, 40
    call    ex_18_mask_range
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
