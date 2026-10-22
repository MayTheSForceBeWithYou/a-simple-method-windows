; Exercise: 13-setb-unsigned
;
; rax=1, rbx=2. cmp; setb al; exit 1 (below unsigned).
; Expected exit: 1
;
.code
ex_13_setb_unsigned PROC
    sub rsp, 40
    mov rax, 1
    mov rbx, 2
    cmp rax, rbx
    setb al
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_13_setb_unsigned ENDP
main PROC
    sub     rsp, 40
    call    ex_13_setb_unsigned
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
