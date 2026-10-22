; Exercise 13: memcpy forward
;
; Copy 8 bytes forward non-overlap; checksum low byte sum of dst. src 1..8 sum=36.
;
; Expected exit: 36
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
src BYTE 1,2,3,4,5,6,7,8

.data?
dst BYTE 8 DUP(?)

.code
ex_13_memcpy_overlap_safe PROC
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    lea rcx, [dst]
    lea rdx, [src]
    mov r8, 8
    call memcpy
    xor r9, r9
    xor r10, r10
sum_loop:
    cmp r10, 8
    jge sum_done
    lea r11, [dst]
    movzx rax, BYTE PTR [r11+r10]
    add r9, rax
    inc r10
    jmp sum_loop
sum_done:
    call ExitProcess
    mov     eax, r9d
    add     rsp, 40
    ret
ex_13_memcpy_overlap_safe ENDP
main PROC
    sub     rsp, 40
    call    ex_13_memcpy_overlap_safe
    mov     rcx, rax
    call    ExitProcess
main ENDP

memcpy PROC
    push rsi
    push rdi
    mov rdi, rcx
    mov rsi, rdx
    mov rcx, r8
    cld
    rep movsb
    pop rdi
    pop rsi
    ret
memcpy ENDP
END
