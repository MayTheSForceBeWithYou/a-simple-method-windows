; Exercise 22: stretch itoa
;
; STRETCH: itoa 123 into buffer; return length 3.
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
buf BYTE 16 DUP(?)

.code
main PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rcx, 123
    lea rdx, buf
    call itoa
    mov rcx, rax
    call ExitProcess
main ENDP

itoa PROC
    mov rax, rcx
    mov r10, 10
    lea r8, [rdx+15]
    mov BYTE PTR [r8], 0
    xor r9, r9
    test rax, rax
    jnz itoa_loop
    mov BYTE PTR [rdx], '0'
    mov BYTE PTR [rdx+1], 0
    mov rax, 1
    ret
itoa_loop:
    xor rdx, rdx
    div r10
    add dl, '0'
    dec r8
    mov BYTE PTR [r8], dl
    inc r9
    test rax, rax
    jnz itoa_loop
    lea rdx, buf
    mov rcx, r9
    mov r11, rdx
itoa_cpy:
    mov al, BYTE PTR [r8]
    mov BYTE PTR [r11], al
    inc r8
    inc r11
    dec rcx
    jnz itoa_cpy
    mov BYTE PTR [r11], 0
    mov rax, r9
    ret
itoa ENDP
END
