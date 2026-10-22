; Exercise 17: precedence
;
; Encode * binds tighter: 2+3*4 = 14; exit 14.
; Expected exit: 14

EXTERN ExitProcess:PROC

.code
ex_17_precedence PROC
    sub rsp, 40
    mov rax, 3
    imul rax, 4
    add rax, 2
        add     rsp, 40
        ret
ex_17_precedence ENDP
main PROC
    sub     rsp, 40
    call    ex_17_precedence
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
