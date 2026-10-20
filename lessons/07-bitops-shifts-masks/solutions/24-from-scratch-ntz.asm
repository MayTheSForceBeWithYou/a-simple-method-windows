; Exercise 24: from scratch ntz
; Number of trailing zeros in 0b1011000 = 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 1011000b
    xor rcx, rcx
loop_ntz:
    test rax, 1
    jnz done_ntz
    shr rax, 1
    inc rcx
    jmp loop_ntz
done_ntz:
    call ExitProcess
main ENDP
END
