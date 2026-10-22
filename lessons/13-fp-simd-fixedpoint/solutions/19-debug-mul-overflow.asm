; Exercise 19: debug mul overflow
; Q16.16 multiply 2.0 * 3.0; exit 6.
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
ex_19_debug_mul_overflow PROC
    sub rsp, 40
    mov eax, 2
    shl eax, 16
    mov ebx, 3
    shl ebx, 16
    movsxd rax, eax
    movsxd rbx, ebx
    imul rax, rbx
    shr rax, 16
    shr rax, 16
    mov     eax, eax
    add rsp, 40
    ret
ex_19_debug_mul_overflow ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_mul_overflow
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
