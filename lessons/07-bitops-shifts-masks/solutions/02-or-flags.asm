; Exercise 02: or flags
; Set bits 0 and 2; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_02_or_flags PROC
    sub rsp, 40
    xor rcx, rcx
    or rcx, 1
    or rcx, 4
    mov     eax, 5
    add     rsp, 40
    ret
ex_02_or_flags ENDP
main PROC
    call    ex_02_or_flags
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
