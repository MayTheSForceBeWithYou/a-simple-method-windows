; Exercise 14: memchr
;
; Find 7 in bytes 3,5,7,9; index 2.
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
buf BYTE 3,5,7,9

.code
ex_14_memchr PROC
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    lea rcx, buf
    mov rdx, 7
    mov r8, 4
    call memchr_idx
        mov     eax, rax
    add     rsp, 40
    ret
ex_14_memchr ENDP
main PROC
    sub     rsp, 40
    call    ex_14_memchr
    mov     rcx, rax
    call    ExitProcess
main ENDP

memchr_idx PROC
    xor rax, rax
mem_loop:
    cmp rax, r8
    jge mem_miss
    movzx r9, BYTE PTR [rcx+rax]
    cmp r9, rdx
    je mem_hit
    inc rax
    jmp mem_loop
mem_miss:
    mov rax, 255
mem_hit:
    ret
memchr_idx ENDP
END
