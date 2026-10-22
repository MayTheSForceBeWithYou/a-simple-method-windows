; Exercise: 02-je-equal
;
; rax=3,rbx=3. If equal exit 1 else 0.
; Expected exit: 1
;
.code
ex_02_je_equal PROC
    sub rsp, 40
    mov rax, 3
    mov rbx, 3
    cmp rax, rbx
    je yes
    xor rcx, rcx
    jmp exit_proc
yes:
    mov rcx, 1
exit_proc:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_02_je_equal ENDP
main PROC
    sub     rsp, 40
    call    ex_02_je_equal
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
