; Exercise 10: strncmp
; strncmp first 2 of "abx","abz" -> 0 (equal for n=2).
; Expected exit: 0

EXTERN ExitProcess:PROC

.data
a BYTE "abx", 0
b BYTE "abz", 0

.code

ex_10_strncmp PROC
lea rcx, a
    lea rdx, b
    mov r8, 2
    call strncmp_fn
    mov rcx, rax
    mov     eax, ecx
    ret
ex_10_strncmp ENDP
main PROC
    sub     rsp, 40
    call    ex_10_strncmp
    mov     rcx, rax
    call    ExitProcess
main ENDP

strncmp_fn PROC
    xor r9, r9
loop_strncmp:
    cmp r9, r8
    jge eq_strncmp
    mov al, BYTE PTR [rcx+r9]
    mov r10b, BYTE PTR [rdx+r9]
    cmp al, r10b
    jne diff_strncmp
    test al, al
    jz eq_strncmp
    inc r9
    jmp loop_strncmp
eq_strncmp:
    xor rax, rax
    ret
diff_strncmp:
    mov rax, 1
    ret
strncmp_fn ENDP
END
