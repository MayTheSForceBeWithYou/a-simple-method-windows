; Exercise 24: from scratch ntz
; Number of trailing zeros in 0b1011000 = 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code

ex_24_from_scratch_ntz PROC
sub rsp, 40
    mov rax, 1011000b
    xor rcx, rcx
loop_ntz:
    test rax, 1
    jnz done_ntz
    shr rax, 1
    inc rcx
    jmp loop_ntz
done_ntz:
    mov     eax, 3
    ret
ex_24_from_scratch_ntz ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_ntz
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
