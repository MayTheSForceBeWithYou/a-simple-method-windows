; Exercise: 02-inc-dec
;
; rax=5; inc; inc; dec; mov rcx,rax; exit (6).
; Expected exit: 6
;
.code
ex_02_inc_dec PROC
    sub rsp, 40
    mov rax, 5
    inc rax
    inc rax
    dec rax
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_02_inc_dec ENDP
main PROC
    sub     rsp, 40
    call    ex_02_inc_dec
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
