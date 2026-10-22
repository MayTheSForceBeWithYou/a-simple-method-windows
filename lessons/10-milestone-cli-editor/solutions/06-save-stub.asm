; Exercise: 06-save-stub
;
; Pretend save ok; exit 0.
; Expected exit: 0
;
.code
ex_06_save_stub PROC
    sub rsp, 40
    mov rcx, 0
    mov     eax, 0
    add     rsp, 40
    ret
ex_06_save_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_06_save_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
