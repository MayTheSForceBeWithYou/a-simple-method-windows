; Exercise: 03-clear-buffer
;
; Clear 8 bytes to 0; exit first byte 0.
; Expected stdout: (none)
; Expected exit: 0
;
.data?
fb BYTE 8 DUP(?)

.code
ex_03_clear_buffer PROC
    sub rsp, 40
    lea rdi, fb
    mov rcx, 8
    xor rax, rax
    rep stosb
    movzx rcx, BYTE PTR [fb]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_clear_buffer ENDP
main PROC
    sub     rsp, 40
    call    ex_03_clear_buffer
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
