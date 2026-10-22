; Exercise 06: popcount naive
; Popcount of 0b101101 = 4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.code

ex_06_popcount_naive PROC
mov rax, 101101b
    xor rcx, rcx
loop_pop:
    test rax, rax
    jz done_pop
    mov rbx, rax
    and rbx, 1
    add rcx, rbx
    shr rax, 1
    jmp loop_pop
done_pop:

    ret
ex_06_popcount_naive ENDP
main PROC
    sub     rsp, 40
    call    ex_06_popcount_naive
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
