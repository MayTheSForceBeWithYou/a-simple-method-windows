; Exercise: 20-macro-with-params
;
; MACRO ADD3 with 3 params; mov rax,a; add b; add c; ADD3 10,20,12 exit 42.
; Expected exit: 42
;
.code
ex_20_macro_with_params PROC
    sub rsp, 40
    
    ADD3 10, 20, 12
    
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_20_macro_with_params ENDP
main PROC
    sub     rsp, 40
    call    ex_20_macro_with_params
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
