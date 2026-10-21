; Exercise 02: mutual even odd
; is_even/is_odd mutual recursion. is_even(4)->1; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 4
    call is_even
    mov rcx, rax
    call ExitProcess
main ENDP

is_even PROC
    cmp rcx, 0
    je yes_even
    dec rcx
    jmp is_odd
yes_even:
    mov rax, 1
    ret
is_even ENDP

is_odd PROC
    cmp rcx, 0
    je no_odd
    dec rcx
    jmp is_even
no_odd:
    xor rax, rax
    ret
is_odd ENDP
END
