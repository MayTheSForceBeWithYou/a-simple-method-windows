; Exercise: 08-from-scratch-macro-add
;
; FROM SCRATCH: MACRO ADD_IMM reg,imm; use to build 40+2 exit 42.
; Expected exit: 42
;
.code
ex_08_from_scratch_macro_add PROC
    sub rsp, 40
    
    mov rcx, 40
    ADD_IMM rcx, 2
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_from_scratch_macro_add ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_macro_add
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
