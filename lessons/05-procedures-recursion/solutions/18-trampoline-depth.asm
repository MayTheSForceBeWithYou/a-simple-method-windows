; Exercise 18: trampoline depth
; bump(8) recursive count. Exit 8.
; Expected exit: 8

EXTERN ExitProcess:PROC

.code
ex_18_trampoline_depth PROC
    sub rsp, 40
    mov rcx, 8
    call bump
    call ExitProcess
    add     rsp, 40
    ret
ex_18_trampoline_depth ENDP
main PROC
    sub     rsp, 40
    call    ex_18_trampoline_depth
    mov     rcx, rax
    call    ExitProcess
main ENDP

bump PROC
    test rcx, rcx
    jz zero_bump
    push rcx
    sub rsp, 40
    dec rcx
    call bump
    add rsp, 40
    pop rcx
    inc rax
    ret
zero_bump:
    xor rax, rax
    ret
bump ENDP
END
