; Exercise: 01-unconditional-jmp
;
; jmp over a mov rcx,99; fallthrough sets rcx=7; exit 7.
; Expected exit: 7
;
.code
ex_01_unconditional_jmp PROC
    sub rsp, 40
    jmp ok
    mov rcx, 99
ok:
    mov rcx, 7
    mov     eax, 7
    add     rsp, 40
    ret
ex_01_unconditional_jmp ENDP
main PROC
    sub     rsp, 40
    call    ex_01_unconditional_jmp
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
