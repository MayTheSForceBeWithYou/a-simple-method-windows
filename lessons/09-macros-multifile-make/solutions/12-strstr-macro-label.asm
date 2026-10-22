; Exercise: 12-strstr-macro-label
;
; MACRO TWICE with inc instructions; exit 2.
; Expected exit: 2
;
.code
ex_12_strstr_macro_label PROC
    sub rsp, 40
    
    xor rcx, rcx
    TWICE
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_12_strstr_macro_label ENDP
main PROC
    sub     rsp, 40
    call    ex_12_strstr_macro_label
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
