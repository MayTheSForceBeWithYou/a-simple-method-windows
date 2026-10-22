; Exercise 13: align before call
; Stack alignment check. MS x64 requires 16-byte alignment before call.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_13_align_before_call PROC
    sub rsp, 40
    call check_align
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_13_align_before_call ENDP
main PROC
    sub     rsp, 40
    call    ex_13_align_before_call
    mov     rcx, rax
    call    ExitProcess
main ENDP

check_align PROC
    mov rax, rsp
    and rax, 15
    cmp rax, 8
    je aligned_ok
    mov rax, 1
    ret
aligned_ok:
    xor rax, rax
    ret
check_align ENDP
END
