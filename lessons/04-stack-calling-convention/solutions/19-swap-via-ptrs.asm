; Exercise 19: swap via ptrs
; swap(&a,&b). a=1,b=2; after swap exit a (2). MS x64 ABI.
; Expected exit: 2

EXTERN ExitProcess:PROC

.data
a QWORD 1
b QWORD 2

.code
ex_19_swap_via_ptrs PROC
    sub rsp, 40
    lea rcx, a
    lea rdx, b
    call swap_ptrs
    mov rcx, a
    mov     eax, ecx
    add     rsp, 40
    ret
ex_19_swap_via_ptrs ENDP
main PROC
    sub     rsp, 40
    call    ex_19_swap_via_ptrs
    mov     rcx, rax
    call    ExitProcess
main ENDP

swap_ptrs PROC
    mov rax, QWORD PTR [rcx]
    mov r8, QWORD PTR [rdx]
    mov QWORD PTR [rcx], r8
    mov QWORD PTR [rdx], rax
    ret
swap_ptrs ENDP
END
