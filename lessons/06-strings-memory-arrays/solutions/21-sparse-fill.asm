; Exercise 21: sparse fill
;
; Fill every other byte in 8-byte buf with 1; sum=4.
;
; Expected exit: 4
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
buf BYTE 8 DUP(0)

.code
ex_21_sparse_fill PROC
    sub rsp, 40
    xor r8, r8
fill_loop:
    cmp r8, 8
    jge do_sum
    test r8, 1
    jnz fill_odd
    lea r11, [buf]
    mov BYTE PTR [r11+r8], 1
fill_odd:
    inc r8
    jmp fill_loop
do_sum:
    xor rcx, rcx
    xor r8, r8
sum_loop:
    cmp r8, 8
    jge sum_done
    lea r11, [buf]
    movzx rax, BYTE PTR [r11+r8]
    add rcx, rax
    inc r8
    jmp sum_loop
sum_done:
    mov     eax, 4
    ret
ex_21_sparse_fill ENDP
main PROC
    call    ex_21_sparse_fill
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
