; Exercise: 03-exit-from-register
;
; Put 42 in rbx, copy to rcx, exit with that status. Immediate only allowed when loading rbx.
; Expected exit: 42
;
.code
ex_03_exit_from_register PROC
    sub rsp, 40
    mov rbx, 42
    mov rcx, rbx
    mov     eax, ebx
    add     rsp, 40
    ret
ex_03_exit_from_register ENDP
main PROC
    sub     rsp, 40
    call    ex_03_exit_from_register
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
