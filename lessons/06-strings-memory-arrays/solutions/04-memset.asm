; Exercise: 04-memset
;
; memset 4 bytes to 7; sum=28.
; Expected exit: 28
;
.data?
buf BYTE 4 DUP(?)

.code
ex_04_memset PROC
    sub rsp, 40
    lea rcx, buf
    mov rdx, 7
    mov r8, 4
    call memset_fn
    xor rcx, rcx
    movzx rax, BYTE PTR buf[0]
    add rcx, rax
    movzx rax, BYTE PTR buf[1]
    add rcx, rax
    movzx rax, BYTE PTR buf[2]
    add rcx, rax
    movzx rax, BYTE PTR buf[3]
    add rcx, rax
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_memset ENDP
main PROC
    sub     rsp, 40
    call    ex_04_memset
    mov     rcx, rax
    call    ExitProcess
main ENDP

memset_fn PROC
loop_set:
    cmp r8, 0
    je done_set
    mov BYTE PTR [rcx], dl
    inc rcx
    dec r8
    jmp loop_set
done_set:
    ret
memset_fn ENDP
END
