; Exercise 21: debug fold bug
;
; BUG: 2*3+4 computed as 2*(3+4). Fix to 10.
; Expected exit: 10

EXTERN ExitProcess:PROC

.code

ex_21_debug_fold_bug PROC
mov rax, 2
    imul rax, 3
    add rax, 4
    mov rcx, rax
    ret
ex_21_debug_fold_bug ENDP
main PROC
    sub     rsp, 40
    call    ex_21_debug_fold_bug
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
