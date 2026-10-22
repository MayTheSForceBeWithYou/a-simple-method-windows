; Exercise 17: closure sim
; Context in r12 (nonvolatile). add_ctx(5)=5+10=15.
; Expected exit: 15

EXTERN ExitProcess:PROC

.data
ctx QWORD 10

.code
ex_17_closure_sim PROC
    sub rsp, 40
    lea r12, ctx
    mov rcx, 5
    call add_ctx
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_17_closure_sim ENDP
main PROC
    sub     rsp, 40
    call    ex_17_closure_sim
    mov     rcx, rax
    call    ExitProcess
main ENDP

add_ctx PROC
    push r12
    mov rax, rcx
    add rax, QWORD PTR [r12]
    pop r12
    ret
add_ctx ENDP
END
