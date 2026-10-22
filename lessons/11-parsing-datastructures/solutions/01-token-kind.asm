; Exercise: 01-token-kind
;
; Token kinds as equ; exit TK_NUM=1.
; Expected exit: 1
;
.code
ex_01_token_kind PROC
    sub rsp, 40
    mov rcx, TK_NUM
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_token_kind ENDP
main PROC
    sub     rsp, 40
    call    ex_01_token_kind
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
