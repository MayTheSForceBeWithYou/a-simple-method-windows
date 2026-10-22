; Exercise: 23-collatz-steps
;
; Collatz steps for n=6 until 1: 6->3->10->5->16->8->4->2->1 = 8 steps. Exit 8.
; Expected exit: 8
;
.code
ex_23_collatz_steps PROC
    sub rsp, 40
    mov rax, 6
    xor rcx, rcx
loop_start:
    cmp rax, 1
    je done
    inc rcx
    test rax, 1
    jnz odd
    shr rax, 1
    jmp loop_start
odd:
    imul rax, 3
    add rax, 1
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_23_collatz_steps ENDP
main PROC
    sub     rsp, 40
    call    ex_23_collatz_steps
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
