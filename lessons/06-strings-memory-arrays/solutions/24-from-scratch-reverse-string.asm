; Exercise 24: from scratch reverse string
;
; FROM SCRATCH: reverse "asm" in place; first byte should be "m"=109.
;
; Expected exit: 109
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
s BYTE "asm", 0

.code
ex_24_from_scratch_reverse_string PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    lea rcx, s
    call strlen_fn
    lea rcx, s
    mov rdx, rax
    call rev
    movzx rcx, BYTE PTR [s]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_24_from_scratch_reverse_string ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_reverse_string
    mov     rcx, rax
    call    ExitProcess
main ENDP

strlen_fn PROC
    mov rax, rcx
len_loop:
    cmp BYTE PTR [rax], 0
    je len_done
    inc rax
    jmp len_loop
len_done:
    sub rax, rcx
    ret
strlen_fn ENDP

rev PROC
    xor r8, r8
    mov r9, rdx
    dec r9
rev_loop:
    cmp r8, r9
    jge rev_done
    mov al, BYTE PTR [rcx+r8]
    mov r10b, BYTE PTR [rcx+r9]
    mov BYTE PTR [rcx+r8], r10b
    mov BYTE PTR [rcx+r9], al
    inc r8
    dec r9
    jmp rev_loop
rev_done:
    ret
rev ENDP
END
