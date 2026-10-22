; Exercise 09: strcmp
; strcmp "abc","abd" -> 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
a BYTE "abc", 0
b BYTE "abd", 0

.code

ex_09_strcmp PROC
lea rcx, a
    lea rdx, b
    call strcmp_fn
    mov rcx, rax
    mov     eax, ecx
    ret
ex_09_strcmp ENDP
main PROC
    sub     rsp, 40
    call    ex_09_strcmp
    mov     rcx, rax
    call    ExitProcess
main ENDP

strcmp_fn PROC
loop_strcmp:
    mov al, BYTE PTR [rcx]
    mov r8b, BYTE PTR [rdx]
    cmp al, r8b
    jne diff_strcmp
    test al, al
    jz eq_strcmp
    inc rcx
    inc rdx
    jmp loop_strcmp
eq_strcmp:
    xor rax, rax
    ret
diff_strcmp:
    mov rax, 1
    ret
strcmp_fn ENDP
END
