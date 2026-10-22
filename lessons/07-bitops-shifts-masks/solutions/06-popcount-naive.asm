; Exercise 06: popcount naive
; Popcount of 0b101101 = 4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.code
ex_06_popcount_naive PROC
    sub rsp, 40
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
    mov     eax, 4
    ret
    add     rsp, 40
ex_06_popcount_naive ENDP
main PROC
    call    ex_06_popcount_naive
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
