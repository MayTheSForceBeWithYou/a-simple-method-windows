; Exercise: 20-count-char
;
; Count 's' in 'mississippi' -> 4.
; Expected stdout: (none)
; Expected exit: 4
;
.data
s BYTE "mississippi", 0

.code
ex_20_count_char PROC
    sub rsp, 40
    lea rdx, s
    xor rcx, rcx
count_loop:
    movzx rax, BYTE PTR [rdx]
    test rax, rax
    jz count_done
    cmp al, 's'
    jne count_next
    inc rcx
count_next:
    inc rdx
    jmp count_loop
count_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_20_count_char ENDP
main PROC
    sub     rsp, 40
    call    ex_20_count_char
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
