; Exercise: 01-define-const
;
; Define constant EXIT; exit 0.
; Expected exit: 0
;
.code
ex_01_define_const PROC
    sub rsp, 40
    mov rcx, SYS_EXIT
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_define_const ENDP
main PROC
    sub     rsp, 40
    call    ex_01_define_const
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
