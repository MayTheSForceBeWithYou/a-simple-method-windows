; Exercise 16: if codegen
;
; if 1 then 7 else 9; exit 7.
; Expected exit: 7

EXTERN ExitProcess:PROC

.code
ex_16_if_codegen PROC
    sub rsp, 40
    mov rax, 1
    test rax, rax
    jz else_branch
    mov rcx, 7
    jmp done
else_branch:
    mov rcx, 9
done:
    mov     eax, 7
    add     rsp, 40
    ret
ex_16_if_codegen ENDP
main PROC
    sub     rsp, 40
    call    ex_16_if_codegen
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
