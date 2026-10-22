; Exercise: 04-zero-with-xor
;
; Zero rdi using xor, then exit 0. No mov immediate.
; Expected exit: 0
;
.code
ex_04_zero_with_xor PROC
    sub rsp, 40
    xor rcx, rcx
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_zero_with_xor ENDP
main PROC
    sub     rsp, 40
    call    ex_04_zero_with_xor
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
