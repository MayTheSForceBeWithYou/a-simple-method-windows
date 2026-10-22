; Exercise: 10-gcd-proc
;
; gcd(48,18)=6 Euclid recursive.
; Expected exit: 6
;
.code
ex_10_gcd_proc PROC
    sub rsp, 40
    mov rcx, 48
    mov rdx, 18
    call gcd
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_10_gcd_proc ENDP
main PROC
    sub     rsp, 40
    call    ex_10_gcd_proc
    mov     rcx, rax
    call    ExitProcess
main ENDP

gcd PROC
    cmp rdx, 0
    je base_gcd
    push rcx
    push rdx
    sub rsp, 40
    mov rax, QWORD PTR [rsp+48]
    xor rdx, rdx
    div QWORD PTR [rsp+40]
    mov rcx, QWORD PTR [rsp+40]
    call gcd
    add rsp, 40
    add rsp, 16
    ret
base_gcd:
    mov rax, rcx
    ret
gcd ENDP
END
