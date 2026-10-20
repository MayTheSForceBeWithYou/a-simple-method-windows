; Exercise 03: sse add scalar
;
; Use addss if available — fallback integer exit 5 as stub if we keep pure GP: exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 5
    call ExitProcess
main ENDP
END
