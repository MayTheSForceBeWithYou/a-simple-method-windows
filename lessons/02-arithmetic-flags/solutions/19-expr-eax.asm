; Exercise 19: expr eax
;
; Compute (3+5)*7-8 into rcx (48).
;
; Build: ml64 /c 19-expr-eax.asm && link /OUT:19-expr-eax.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-expr-eax.obj kernel32.lib
;
; Expected exit: 48

EXTERN ExitProcess:PROC

.code
ex_19_expr_eax PROC
    sub rsp, 40
    mov rax, 3
    add rax, 5
    imul rax, 7
    sub rax, 8
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_19_expr_eax ENDP
main PROC
    sub     rsp, 40
    call    ex_19_expr_eax
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
