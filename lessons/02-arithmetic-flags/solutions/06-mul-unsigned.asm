; Exercise: 06-mul-unsigned
;
; rax=100000, rbx=3; mul rbx; exit with low 8 bits of rax. Product 300000, status 300000&255=224.
; Expected exit: 224
;
.code
ex_06_mul_unsigned PROC
    sub rsp, 40
    mov rax, 100000
    mov rbx, 3
    mul rbx
    mov rcx, rax
    and rcx, 255
    mov     eax, ecx
    add     rsp, 40
    ret
ex_06_mul_unsigned ENDP
main PROC
    sub     rsp, 40
    call    ex_06_mul_unsigned
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
