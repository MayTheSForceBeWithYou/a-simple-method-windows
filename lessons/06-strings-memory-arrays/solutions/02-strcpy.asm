; Exercise 02: strcpy
; Copy 'yo' to bss; exit length=2.
; Expected exit: 2

EXTERN ExitProcess:PROC

.data
src BYTE "yo", 0

.data?
dst BYTE 8 DUP(?)

.code
ex_02_strcpy PROC
    sub rsp, 40
    lea rcx, dst
    lea rdx, src
    call strcpy_fn
    lea rcx, dst
    call strlen_fn
        mov     eax, ecx
    add     rsp, 40
    ret
ex_02_strcpy ENDP
main PROC
    sub     rsp, 40
    call    ex_02_strcpy
    mov     rcx, rax
    call    ExitProcess
main ENDP

strcpy_fn PROC
    mov rax, rcx
loop_cpy:
    mov r8b, BYTE PTR [rdx]
    mov BYTE PTR [rcx], r8b
    inc rdx
    inc rcx
    test r8b, r8b
    jnz loop_cpy
    ret
strcpy_fn ENDP

strlen_fn PROC
    mov rax, rcx
loop_len:
    cmp BYTE PTR [rax], 0
    je done_len
    inc rax
    jmp loop_len
done_len:
    sub rax, rcx
    ret
strlen_fn ENDP
END
