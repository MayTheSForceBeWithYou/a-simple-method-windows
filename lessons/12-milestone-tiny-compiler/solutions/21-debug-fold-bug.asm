; Exercise 21: debug fold bug
;
; BUG: 2*3+4 computed as 2*(3+4). Fix to 10.
; Expected exit: 10

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 2
    imul rax, 3
    add rax, 4
    mov rcx, rax
    call ExitProcess
main ENDP
END
