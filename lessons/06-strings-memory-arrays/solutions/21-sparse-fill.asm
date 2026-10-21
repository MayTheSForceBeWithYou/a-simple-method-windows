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
main PROC
    sub rsp, 40
    xor r8, r8
fill_loop:
    cmp r8, 8
    jge do_sum
    test r8, 1
    jnz fill_odd
    mov BYTE PTR [buf+r8], 1
fill_odd:
    inc r8
    jmp fill_loop
do_sum:
    xor rcx, rcx
    xor r8, r8
sum_loop:
    cmp r8, 8
    jge sum_done
    movzx rax, BYTE PTR [buf+r8]
    add rcx, rax
    inc r8
    jmp sum_loop
sum_done:
    call ExitProcess
main ENDP
END
