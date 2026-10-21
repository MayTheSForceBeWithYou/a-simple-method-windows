; Exercise 10: gcd proc
; gcd(48,18)=6 Euclid recursive.
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 48
    mov rdx, 18
    call gcd
    mov rcx, rax
    call ExitProcess
main ENDP

gcd PROC
    cmp rdx, 0
    je base_gcd
    push rcx
    push rdx
    sub rsp, 40
    mov rax, rcx
    xor rdx, rdx
    mov r8, QWORD PTR [rsp+32]
    div r8
    mov rcx, QWORD PTR [rsp+32]
    call gcd
    add rsp, 40
    add rsp, 16
    ret
base_gcd:
    mov rax, rcx
    ret
gcd ENDP
END
