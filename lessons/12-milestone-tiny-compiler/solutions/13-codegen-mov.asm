; Exercise 13: codegen mov
;
; Emit conceptual: store imm 42 into slot; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
slot QWORD ?

.code
ex_13_codegen_mov PROC
    sub rsp, 40
    mov QWORD PTR [slot], 42
        mov     eax, QWORD PTR [slot]
    add     rsp, 40
    ret
ex_13_codegen_mov ENDP
main PROC
    call    ex_13_codegen_mov
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
