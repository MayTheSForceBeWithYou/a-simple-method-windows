; Exercise 14: codegen add regs
;
; v1=10 v2=32; add into v1; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
v1 QWORD ?
v2 QWORD ?

.code
ex_14_codegen_add_regs PROC
    sub rsp, 40
    mov QWORD PTR [v1], 10
    mov QWORD PTR [v2], 32
    mov rax, QWORD PTR [v1]
    add rax, QWORD PTR [v2]
    mov QWORD PTR [v1], rax
        mov     eax, rax
    add     rsp, 40
    ret
ex_14_codegen_add_regs ENDP
main PROC
    call    ex_14_codegen_add_regs
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
