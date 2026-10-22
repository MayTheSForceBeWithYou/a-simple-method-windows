; Exercise: 01-add-sub
;
; rcx=100; add 20; sub 78; exit (42).
; Expected exit: 42
;
.code
ex_01_add_sub PROC
    sub rsp, 40
    mov rcx, 100
    add rcx, 20
    sub rcx, 78
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_add_sub ENDP
main PROC
    sub     rsp, 40
    call    ex_01_add_sub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
