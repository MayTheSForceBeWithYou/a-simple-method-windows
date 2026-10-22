; Exercise 04: codegen add
;
; Fold 2+3 at compile-time; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_04_codegen_add PROC
    sub rsp, 40
    mov rcx, 2
    add rcx, 3
    mov     eax, 5
    ret
ex_04_codegen_add ENDP
main PROC
    call    ex_04_codegen_add
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
