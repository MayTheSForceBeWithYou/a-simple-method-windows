; Exercise 08: from scratch rec pow
; pow(base,exp) recursive. pow(2,5)=32.
; Expected exit: 32

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 2
    mov rdx, 5
    call pow_fn
    mov rcx, rax
    call ExitProcess
main ENDP

pow_fn PROC
    cmp rdx, 0
    je one_pow
    push rcx
    sub rsp, 40
    dec rdx
    call pow_fn
    add rsp, 40
    pop rcx
    imul rax, rcx
    ret
one_pow:
    mov rax, 1
    ret
pow_fn ENDP
END
