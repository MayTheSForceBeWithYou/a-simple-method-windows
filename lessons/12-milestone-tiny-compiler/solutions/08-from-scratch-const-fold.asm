; Exercise 08: from scratch const fold
;
; FROM SCRATCH: fold (1+2)*3 exit 9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.code
ex_08_from_scratch_const_fold PROC
    sub rsp, 40
    mov rax, 1
    add rax, 2
    imul rax, 3
        add     rsp, 40
        ret
ex_08_from_scratch_const_fold ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_const_fold
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
