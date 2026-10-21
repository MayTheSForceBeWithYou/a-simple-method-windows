; Exercise 11: strchr
; Find 'l' in 'hello' -> index 2.
; Expected exit: 2

EXTERN ExitProcess:PROC

.data
s BYTE "hello", 0

.code
main PROC
    sub rsp, 40
    lea rcx, s
    mov rdx, 'l'
    call strchr_idx
    mov rcx, rax
    call ExitProcess
main ENDP

strchr_idx PROC
    xor rax, rax
loop_chr:
    movzx r8, BYTE PTR [rcx+rax]
    test r8, r8
    jz miss_chr
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
