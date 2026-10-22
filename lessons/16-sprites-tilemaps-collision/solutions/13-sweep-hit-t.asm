; Exercise: 13-sweep-hit-t
;
; TOI stub t=3; exit 3.
; Expected stdout: (none)
; Expected exit: 3
;
.code
ex_13_sweep_hit_t PROC
    sub rsp, 40
    mov rcx, 3
    mov     eax, 3
    add     rsp, 40
    ret
ex_13_sweep_hit_t ENDP
main PROC
    sub     rsp, 40
    call    ex_13_sweep_hit_t
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
