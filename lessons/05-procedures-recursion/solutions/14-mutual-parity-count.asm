; Exercise 14: mutual parity count
; is_even(6)=1. MS x64 ABI.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_14_mutual_parity_count PROC
    sub rsp, 40
    mov rcx, 6
    call is_even
        mov     eax, rax
    ret

ex_14_mutual_parity_count ENDP
main PROC
    call    ex_14_mutual_parity_count
    mov     rcx, rax
    call    ExitProcess
main ENDP

is_even PROC
    test rcx, rcx
    jz yes_even
    dec rcx
    jmp is_odd
yes_even:
    mov rax, 1
    ret
is_even ENDP

is_odd PROC
    test rcx, rcx
    jz no_odd
    dec rcx
    jmp is_even
no_odd:
    xor rax, rax
    ret
is_odd ENDP
END
