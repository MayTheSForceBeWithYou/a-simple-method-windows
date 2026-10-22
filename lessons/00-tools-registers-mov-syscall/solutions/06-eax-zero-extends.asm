; Exercise: 06-eax-zero-extends
;
; Set rax to all 0FFh bytes, then mov eax, 1. Exit with rcx=rax (should be 1).
; Expected exit: 1
;
.code
ex_06_eax_zero_extends PROC
    sub rsp, 40
    mov rax, 0FFFFFFFFFFFFFFFFh
    mov eax, 1
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_06_eax_zero_extends ENDP
main PROC
    sub     rsp, 40
    call    ex_06_eax_zero_extends
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
