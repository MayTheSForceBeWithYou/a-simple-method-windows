; Exercise 11: recursion fact
; Recursive fact(4)=24. MS x64 ABI.
; Expected exit: 24

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 4
    call fact
    mov rcx, rax
    call ExitProcess
main ENDP

fact PROC
    cmp rcx, 1
    jle base_case
    push rcx
    sub rsp, 40
    dec rcx
    call fact
    add rsp, 40
    pop rcx
    imul rax, rcx
    ret
base_case:
    mov rax, 1
    ret
fact ENDP
END
