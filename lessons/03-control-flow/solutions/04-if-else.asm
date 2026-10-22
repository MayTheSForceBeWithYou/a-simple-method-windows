; Exercise: 04-if-else
;
; If rax>10 exit 1 else exit 2. Set rax=11.
; Expected exit: 1
;
.code
ex_04_if_else PROC
    sub rsp, 40
    mov rax, 11
    cmp rax, 10
    jg then_branch
    mov rcx, 2
    jmp L_done
then_branch:
    mov rcx, 1
L_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_if_else ENDP
main PROC
    sub     rsp, 40
    call    ex_04_if_else
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
