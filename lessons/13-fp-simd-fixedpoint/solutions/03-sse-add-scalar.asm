; Exercise 03: sse add scalar
;
; Use addss if available — fallback integer exit 5 as stub if we keep pure GP: exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_03_sse_add_scalar PROC
    sub rsp, 40
        mov     eax, ecx
    add     rsp, 40
    ret
ex_03_sse_add_scalar ENDP
main PROC
    sub     rsp, 40
    call    ex_03_sse_add_scalar
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
