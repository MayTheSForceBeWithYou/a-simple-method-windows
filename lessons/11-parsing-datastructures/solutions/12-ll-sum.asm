; Exercise 12: ll sum
;
; List 3->4->5; sum=12.
; Expected exit: 12

EXTERN ExitProcess:PROC

.data
n3 QWORD 5, 0
n2 QWORD 4, 0
n1 QWORD 3, 0

.code
ex_12_ll_sum PROC
    sub rsp, 40
    lea rax, n3
    mov QWORD PTR [n2+8], rax
    lea rax, n2
    mov QWORD PTR [n1+8], rax
    lea rsi, n1
    xor rcx, rcx
loop_sum:
    test rsi, rsi
    jz done_sum
    add rcx, QWORD PTR [rsi]
    mov rsi, QWORD PTR [rsi+8]
    jmp loop_sum
done_sum:
    mov     eax, 12
    add     rsp, 40
    ret
ex_12_ll_sum ENDP
main PROC
    call    ex_12_ll_sum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
