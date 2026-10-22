; Exercise: 05-imul-three
;
; Set rcx=6 then imul rcx,7. Exit 42.
; Expected exit: 42
;
.code
ex_05_imul_three PROC
    sub rsp, 40
    mov rcx, 6
    imul rcx, 7
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_imul_three ENDP
main PROC
    sub     rsp, 40
    call    ex_05_imul_three
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
