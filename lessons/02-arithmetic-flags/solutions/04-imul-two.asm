; Exercise: 04-imul-two
;
; imul-style: rax=6, imul rax,7; mov rcx,rax; exit 42.
; Expected exit: 42
;
.code
ex_04_imul_two PROC
    sub rsp, 40
    mov rax, 6
    imul rax, 7
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_04_imul_two ENDP
main PROC
    sub     rsp, 40
    call    ex_04_imul_two
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
