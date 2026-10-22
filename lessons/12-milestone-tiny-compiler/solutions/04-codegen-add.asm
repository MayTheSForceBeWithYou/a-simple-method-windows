; Exercise: 04-codegen-add
;
; Fold 2+3 at compile-time; exit 5.
; Expected exit: 5
;
.code
ex_04_codegen_add PROC
    sub rsp, 40
    mov rcx, 2
    add rcx, 3
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_codegen_add ENDP
main PROC
    sub     rsp, 40
    call    ex_04_codegen_add
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
