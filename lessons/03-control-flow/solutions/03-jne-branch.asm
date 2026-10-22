; Exercise: 03-jne-branch
;
; rax=1,rbx=2. jne -> exit 5; if equal would exit 0.
; Expected exit: 5
;
.code
ex_03_jne_branch PROC
    sub rsp, 40
    mov rax, 1
    mov rbx, 2
    cmp rax, rbx
    jne diff
    xor rcx, rcx
    jmp exit_proc
diff:
    mov rcx, 5
exit_proc:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_jne_branch ENDP
main PROC
    sub     rsp, 40
    call    ex_03_jne_branch
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
