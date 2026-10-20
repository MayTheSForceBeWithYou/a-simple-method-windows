; Exercise 01: locals three
; Function with 3 qword locals. sum_locals(10)=10+11+12=33.
; Expected exit: 33

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 10
    call sum_locals
    mov rcx, rax
    call ExitProcess
main ENDP

sum_locals PROC
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov QWORD PTR [rbp-8], rcx
    mov rax, rcx
    inc rax
    mov QWORD PTR [rbp-16], rax
    inc rax
    mov QWORD PTR [rbp-24], rax
    mov rax, QWORD PTR [rbp-8]
    add rax, QWORD PTR [rbp-16]
    add rax, QWORD PTR [rbp-24]
    leave
    ret
sum_locals ENDP
END
