; Exercise: 06-prologue-locals
;
; Function stores local = rcx+1 on stack frame; returns it. Call with 41; exit 42.
; Expected exit: 42
;
.code
ex_06_prologue_locals PROC
    sub rsp, 40
    mov rcx, 41
    call inc_local
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_06_prologue_locals ENDP
main PROC
    sub     rsp, 40
    call    ex_06_prologue_locals
    mov     rcx, rax
    call    ExitProcess
main ENDP

inc_local PROC
    push rbp
    mov rbp, rsp
    sub rsp, 40 ; locals + alignment
    mov rax, rcx
    add rax, 1
    mov QWORD PTR [rbp-8], rax
    mov rax, QWORD PTR [rbp-8]
    mov rsp, rbp
    pop rbp
    ret
inc_local ENDP
END
