; Exercise: 17-clock-diff
;
; t1-t0 = 40; exit 40.
; Expected stdout: (none)
; Expected exit: 40
;
.code
ex_17_clock_diff PROC
    sub rsp, 40
    mov rax, 100
    mov rbx, 60
    sub rax, rbx
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_17_clock_diff ENDP
main PROC
    sub     rsp, 40
    call    ex_17_clock_diff
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
