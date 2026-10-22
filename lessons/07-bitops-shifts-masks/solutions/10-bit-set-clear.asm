; Exercise 10: bit set clear
; Set bit 3, then clear it; exit 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_10_bit_set_clear PROC
    sub rsp, 40
    xor rcx, rcx
    or rcx, (1 SHL 3)
    and rcx, NOT (1 SHL 3)
    mov     eax, 0
    ret
    add     rsp, 40
ex_10_bit_set_clear ENDP
main PROC
    call    ex_10_bit_set_clear
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
