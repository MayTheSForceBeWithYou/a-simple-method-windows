; Exercise 05: hash mix
;
; x=5; x^=x<<3; exit low byte.
; Expected exit: 45

EXTERN ExitProcess:PROC

.code

ex_05_hash_mix PROC
mov rax, 5
    mov rbx, rax
    shl rbx, 3
    xor rax, rbx
    movzx rcx, al
    ret
ex_05_hash_mix ENDP
main PROC
    sub     rsp, 40
    call    ex_05_hash_mix
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
