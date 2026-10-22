; Exercise: 01-and-mask
;
; Expected exit: 15
;
.code
ex_01_and_mask PROC
    sub rsp, 40
    mov rax, 0FFh
    and rax, 0Fh
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_01_and_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_01_and_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
