; Exercise 01: fixed mul
;
; Q16.16: 2.0 * 3.0 -> 6.0; represent 2<<16 etc; result>>16 exit 6.
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
ex_01_fixed_mul PROC
    sub rsp, 40
    mov eax, 2
    shl eax, 16
    mov ebx, 3
    shl ebx, 16
    movsxd rax, eax
    movsxd rbx, ebx
    imul rax, rbx
    shr rax, 32
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_01_fixed_mul ENDP
main PROC
    sub     rsp, 40
    call    ex_01_fixed_mul
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
