; Exercise: 15-debug-inc-cf
;
; Educational: compute 0FFh as byte in al, add 1 to al (wraps). Exit with CF materialized: after add, setc al; movzx rcx,al expect 1.
; Expected exit: 1
;
.code
ex_15_debug_inc_cf PROC
    sub rsp, 40
    mov al, 0FFh
    add al, 1
    setc al
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_debug_inc_cf ENDP
main PROC
    sub     rsp, 40
    call    ex_15_debug_inc_cf
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
