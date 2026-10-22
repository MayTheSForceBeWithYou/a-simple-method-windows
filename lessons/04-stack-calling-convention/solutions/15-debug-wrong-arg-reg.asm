; Exercise 15: debug wrong arg reg
; BUG fixed: use rdx. add(2,40)=42. MS x64 ABI.
; Expected exit: 42

EXTERN ExitProcess:PROC

.code

ex_15_debug_wrong_arg_reg PROC
mov rcx, 2
    mov rdx, 40
    call add2
    mov rcx, rax
    mov     eax, rax
    ret
ex_15_debug_wrong_arg_reg ENDP
main PROC
    sub     rsp, 40
    call    ex_15_debug_wrong_arg_reg
    mov     rcx, rax
    call    ExitProcess
main ENDP

add2 PROC
    mov rax, rcx
    add rax, rdx
    ret
add2 ENDP
END
