; Exercise 01: emit mov imm
;
; Compiler-ish: 'emit' by writing value 42 to out cell; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
outv QWORD ?

.code
ex_01_emit_mov_imm PROC
    sub rsp, 40
    mov QWORD PTR [outv], 42
        mov     eax, QWORD PTR [outv]
    ret
    add     rsp, 40
ex_01_emit_mov_imm ENDP
main PROC
    call    ex_01_emit_mov_imm
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
