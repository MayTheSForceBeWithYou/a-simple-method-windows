; Exercise 12: parse paren
;
; (1+2)*3 = 9; exit 9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.code
ex_12_parse_paren PROC
    sub rsp, 40
    mov rax, 1
    add rax, 2
    imul rax, 3
        add     rsp, 40
        ret
ex_12_parse_paren ENDP
main PROC
    sub     rsp, 40
    call    ex_12_parse_paren
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
