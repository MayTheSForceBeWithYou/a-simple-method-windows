; Exercise: 03-neg
;
; mov rcx, 5; neg rcx; add rcx, 10; exit (5).
; Expected exit: 5
;
.code
ex_03_neg PROC
    sub rsp, 40
    mov rcx, 5
    neg rcx
    add rcx, 10
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_neg ENDP
main PROC
    sub     rsp, 40
    call    ex_03_neg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
