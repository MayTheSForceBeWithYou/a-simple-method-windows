; Exercise 12: next power check
; Test if 16 is power of two; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 16
    test rax, rax
    jz not_pow2
    mov rbx, rax
    dec rbx
    test rax, rbx
    jnz not_pow2
    mov rcx, 1
    jmp done_pow2
not_pow2:
    xor rcx, rcx
done_pow2:
    call ExitProcess
main ENDP
END
