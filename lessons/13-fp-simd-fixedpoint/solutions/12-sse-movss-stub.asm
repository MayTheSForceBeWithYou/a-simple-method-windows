; Exercise 12: sse movss stub
;
; Prefer portable: store float bits of 1.0 as imm and mask; exit 1 as success flag.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_12_sse_movss_stub PROC
    sub rsp, 40
        mov     eax, 1
    ret

ex_12_sse_movss_stub ENDP
main PROC
    call    ex_12_sse_movss_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
