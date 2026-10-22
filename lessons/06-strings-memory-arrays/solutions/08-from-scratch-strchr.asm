; Exercise 08: from scratch strchr
; strchr 'c' in 'abcd' -> index 2.
; Expected exit: 2

EXTERN ExitProcess:PROC

.data
s BYTE "abcd", 0

.code
ex_08_from_scratch_strchr PROC
    sub rsp, 40
    lea rcx, s
    mov rdx, 'c'
    call strchr_idx
        mov     eax, rax
    add     rsp, 40
    ret
ex_08_from_scratch_strchr ENDP
main PROC
    call    ex_08_from_scratch_strchr
    mov     rcx, rax
    call    ExitProcess
main ENDP

strchr_idx PROC
    xor rax, rax
loop_chr:
    movzx r8, BYTE PTR [rcx+rax]
    cmp r8, 0
    je miss_chr
    cmp r8, rdx
    je hit_chr
    inc rax
    jmp loop_chr
miss_chr:
    mov rax, 255
hit_chr:
    ret
strchr_idx ENDP
END
