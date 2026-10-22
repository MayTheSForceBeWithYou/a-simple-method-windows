; Exercise 14: debug missing ret
; BUG fixed: added ret. Exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
ex_14_debug_missing_ret PROC
    sub rsp, 40
    call three
        mov     eax, rax
    ret
    add     rsp, 40
ex_14_debug_missing_ret ENDP
main PROC
    call    ex_14_debug_missing_ret
    mov     rcx, rax
    call    ExitProcess
main ENDP

three PROC
    mov rax, 3
    ret
three ENDP
END
