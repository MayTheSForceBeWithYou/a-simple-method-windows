; Exercise 20: clz loop
; Count leading zeros in 0x00F0 (16-bit) -> 8.
; Expected exit: 8

EXTERN ExitProcess:PROC

.data
val WORD 00F0h

.code

ex_20_count_leading_zeros_loop PROC
sub rsp, 40
    movzx rax, val
    xor rcx, rcx
    mov r8, 16
loop_clz:
    test rax, rax
    jz pad_clz
    test rax, 8000h
    jnz done_clz
    shl rax, 1
    inc rcx
    dec r8
    jnz loop_clz
    jmp done_clz
pad_clz:
    mov rcx, 16
done_clz:
    mov     eax, 8
    ret
ex_20_count_leading_zeros_loop ENDP
main PROC
    sub     rsp, 40
    call    ex_20_count_leading_zeros_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
