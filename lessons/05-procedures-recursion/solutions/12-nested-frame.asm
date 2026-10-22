; Exercise 12: nested frame
; outer calls inner. inner returns rcx+rdx. outer adds 1. outer(10,20)=31.
; Expected exit: 31

EXTERN ExitProcess:PROC

.code

ex_12_nested_frame PROC
mov rcx, 10
    mov rdx, 20
    call outer
    mov rcx, rax
    mov     eax, ecx
    ret
ex_12_nested_frame ENDP
main PROC
    sub     rsp, 40
    call    ex_12_nested_frame
    mov     rcx, rax
    call    ExitProcess
main ENDP

outer PROC
    push rbp
    mov rbp, rsp
    sub rsp, 40
    call inner
    inc rax
    leave
    ret
outer ENDP

inner PROC
    push rbp
    mov rbp, rsp
    mov rax, rcx
    add rax, rdx
    leave
    ret
inner ENDP
END
