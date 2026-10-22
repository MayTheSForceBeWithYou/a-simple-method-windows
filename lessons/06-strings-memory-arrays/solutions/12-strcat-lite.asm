; Exercise 12: strcat lite
; dst="Hi", append "!", final length=3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
dst BYTE "Hi", 0, 0, 0, 0
src BYTE "!", 0

.code
ex_12_strcat_lite PROC
    sub rsp, 40
    lea rcx, dst
    lea rdx, src
    call strcat_fn
    lea rcx, dst
    call strlen_fn
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_12_strcat_lite ENDP
main PROC
    sub     rsp, 40
    call    ex_12_strcat_lite
    mov     rcx, rax
    call    ExitProcess
main ENDP

strcat_fn PROC
    push rcx
    call strlen_fn
    pop rcx
    add rcx, rax
loop_cat:
    mov r8b, BYTE PTR [rdx]
    mov BYTE PTR [rcx], r8b
    inc rdx
    inc rcx
    test r8b, r8b
    jnz loop_cat
    ret
strcat_fn ENDP

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
