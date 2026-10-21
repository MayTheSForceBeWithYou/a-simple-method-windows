; Exercise 05: hash mix
;
; x=5; x^=x<<3; exit low byte.
; Expected exit: 45

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 5
    mov rbx, rax
    shl rbx, 3
    xor rax, rbx
    movzx rcx, al
    call ExitProcess
main ENDP
END
