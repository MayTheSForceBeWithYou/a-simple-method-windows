; Exercise: 21-min-via-cmovl
;
; Same with 17 and 23; min into rcx (17) using cmovl.
; Expected exit: 17
;
.code
ex_21_min_via_cmovl PROC
    sub rsp, 40
    mov rax, 17
    mov rbx, 23
    mov rcx, rax
    cmp rbx, rcx
    cmovl rcx, rbx
    mov     eax, ecx
    add     rsp, 40
    ret
ex_21_min_via_cmovl ENDP
main PROC
    sub     rsp, 40
    call    ex_21_min_via_cmovl
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
