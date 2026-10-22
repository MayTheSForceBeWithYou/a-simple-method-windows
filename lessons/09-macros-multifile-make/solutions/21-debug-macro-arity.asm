; Exercise: 21-debug-macro-arity
;
; BUG: macro invoked with wrong arg count conceptually; fix EXIT_STATUS 4.
; Expected exit: 4
;
.code
ex_21_debug_macro_arity PROC
    sub rsp, 40
    EXIT_STATUS 4
ex_21_debug_macro_arity ENDP
main PROC
    sub     rsp, 40
    call    ex_21_debug_macro_arity
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
