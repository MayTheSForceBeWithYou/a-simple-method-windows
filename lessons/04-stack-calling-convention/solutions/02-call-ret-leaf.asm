; Exercise: 02-call-ret-leaf
;
; Write leaf answer that returns 42 in rax. call it; exit with that.
; Expected exit: 42
;
.code
ex_02_call_ret_leaf PROC
    sub rsp, 40
    call answer
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_02_call_ret_leaf ENDP
main PROC
    sub     rsp, 40
    call    ex_02_call_ret_leaf
    mov     rcx, rax
    call    ExitProcess
main ENDP

answer PROC
    mov rax, 42
    ret
answer ENDP
END
