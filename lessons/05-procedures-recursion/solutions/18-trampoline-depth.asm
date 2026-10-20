; Exercise 18: trampoline depth
; bump(8) recursive count. Exit 8.
; Expected exit: 8

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 8
    call bump
    mov rcx, rax
    call ExitProcess
main ENDP

bump PROC
    test rcx, rcx
    jz zero_bump
    push rcx
    sub rsp, 32
    dec rcx
    call bump
    add rsp, 32
    pop rcx
    inc rax
    ret
zero_bump:
    xor rax, rax
    ret
bump ENDP
END
