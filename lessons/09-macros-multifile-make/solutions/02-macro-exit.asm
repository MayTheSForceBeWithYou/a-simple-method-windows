; Exercise: 02-macro-exit
;
; MACRO exit_with code ... ENDM; exit 7.
; Expected exit: 7
;
.code
ex_02_macro_exit PROC
    sub rsp, 40
    exit_with 7
ex_02_macro_exit ENDP
main PROC
    sub     rsp, 40
    call    ex_02_macro_exit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
