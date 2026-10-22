; Exercise: 20-clamp
;
; x=150. Clamp to [0,100]. Exit 100.
; Expected exit: 100
;
.code
ex_20_clamp PROC
    sub rsp, 40
    mov rax, 150
    cmp rax, 0
    jge hi
    xor rax, rax
hi:
    cmp rax, 100
    jle ok
    mov rax, 100
ok:
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_20_clamp ENDP
main PROC
    sub     rsp, 40
    call    ex_20_clamp
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
