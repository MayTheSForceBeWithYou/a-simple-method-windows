; Exercise 16: debug callee clobber
; BUG fixed: preserve rbx. Exit 11.
; Expected exit: 11

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rbx, 11
    call evil
    mov rcx, rbx
    call ExitProcess
main ENDP

evil PROC
    push rbx
    mov rbx, 0
    pop rbx
    ret
evil ENDP
END
