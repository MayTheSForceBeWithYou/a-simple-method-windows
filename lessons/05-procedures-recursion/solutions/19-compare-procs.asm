; Exercise 19: compare procs
; cmp_i64(3,5) returns 0 for less, 1 for eq, 2 for greater. Exit 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_19_compare_procs PROC
    sub rsp, 40
    mov rcx, 3
    mov rdx, 5
    call cmp_i64
    call ExitProcess
    add     rsp, 40
    ret
ex_19_compare_procs ENDP
main PROC
    sub     rsp, 40
    call    ex_19_compare_procs
    mov     rcx, rax
    call    ExitProcess
main ENDP

cmp_i64 PROC
    cmp rcx, rdx
    jl less_cmp
    je equal_cmp
    mov rax, 2
    ret
less_cmp:
    xor rax, rax
    ret
equal_cmp:
    mov rax, 1
    ret
cmp_i64 ENDP
END
