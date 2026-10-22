; Exercise 21: fast inv stub
;
; Integer reciprocal stub for 1/2 of 10 -> 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_21_fast_inv_stub PROC
    sub rsp, 40
    mov rax, 10
    shr rax, 1
        mov     eax, rax
    ret
    add     rsp, 40
ex_21_fast_inv_stub ENDP
main PROC
    call    ex_21_fast_inv_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
