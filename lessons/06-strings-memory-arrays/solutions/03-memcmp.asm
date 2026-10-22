; Exercise 03: memcmp
; memcmp 3 bytes; equal -> 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.data
a BYTE 1,2,3
b BYTE 1,2,3

.code
ex_03_memcmp PROC
    sub rsp, 40
    lea rcx, a
    lea rdx, b
    mov r8, 3
    call memcmp_fn
    call ExitProcess
    add     rsp, 40
    ret
ex_03_memcmp ENDP
main PROC
    sub     rsp, 40
    call    ex_03_memcmp
    mov     rcx, rax
    call    ExitProcess
main ENDP

memcmp_fn PROC
    xor rax, rax
loop_cmp:
    cmp r8, 0
    je done_cmp
    mov r9b, BYTE PTR [rcx]
    mov r10b, BYTE PTR [rdx]
    cmp r9b, r10b
    jne diff_cmp
    inc rcx
    inc rdx
    dec r8
    jmp loop_cmp
diff_cmp:
    mov rax, 1
done_cmp:
    ret
memcmp_fn ENDP
END
