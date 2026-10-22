; Exercise 16: debug callee clobber
; BUG fixed: preserve rbx. Exit 11.
; Expected exit: 11

EXTERN ExitProcess:PROC

.code
ex_16_debug_callee_clobber PROC
    sub rsp, 40
    mov rbx, 11
    call evil
        mov     eax, rbx
    add     rsp, 40
    ret
ex_16_debug_callee_clobber ENDP
main PROC
    sub     rsp, 40
    call    ex_16_debug_callee_clobber
    mov     rcx, rax
    call    ExitProcess
main ENDP

evil PROC
    push rbx
    mov rbx, 0
    pop rbx
    ret
evil ENDP
END
