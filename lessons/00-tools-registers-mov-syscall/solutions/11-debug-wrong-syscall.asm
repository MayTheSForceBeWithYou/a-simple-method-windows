; Exercise: 11-debug-wrong-syscall
;
; BUG HUNT: Intends to exit status 3 but uses wrong function. Fix it.
; Expected exit: 3
;
.code
ex_11_debug_wrong_syscall PROC
    sub rsp, 40
    mov rcx, 3
    mov     eax, 3
    add     rsp, 40
    ret
ex_11_debug_wrong_syscall ENDP
main PROC
    sub     rsp, 40
    call    ex_11_debug_wrong_syscall
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
