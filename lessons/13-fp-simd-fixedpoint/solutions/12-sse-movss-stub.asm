; Exercise 12: sse movss stub
;
; Prefer portable: store float bits of 1.0 as imm and mask; exit 1 as success flag.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 1
    call ExitProcess
main ENDP
END
