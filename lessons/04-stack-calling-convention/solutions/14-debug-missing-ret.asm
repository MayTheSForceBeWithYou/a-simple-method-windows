; Exercise: 14-debug-missing-ret
;
; BUG fixed: added ret. Exit 3.
; Expected exit: 3
;
.code
ex_14_debug_missing_ret PROC
    sub rsp, 40
    call three
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_14_debug_missing_ret ENDP
main PROC
    sub     rsp, 40
    call    ex_14_debug_missing_ret
    mov     rcx, rax
    call    ExitProcess
main ENDP

three PROC
    mov rax, 3
    ret
three ENDP
END
