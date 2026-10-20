; Exercise 21: fast inv stub
;
; Integer reciprocal stub for 1/2 of 10 -> 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 10
    shr rax, 1
    mov rcx, rax
    call ExitProcess
main ENDP
END
