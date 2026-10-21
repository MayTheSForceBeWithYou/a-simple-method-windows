; Exercise 14: debug missing ret
; BUG fixed: added ret. Exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    call three
    mov rcx, rax
    call ExitProcess
main ENDP

three PROC
    mov rax, 3
    ret
three ENDP
END
