; Exercise: 10-lex-ident-len
;
; Ident "foo" length 3; exit 3.
; Expected exit: 3
;
.data
s BYTE "foo", 0

.code
ex_10_lex_ident_len PROC
    sub rsp, 40
    lea rsi, s
    xor rcx, rcx
loop_len:
    movzx rax, BYTE PTR [rsi]
    cmp al, 'a'
    jb done_len
    cmp al, 'z'
    ja done_len
    inc rcx
    inc rsi
    jmp loop_len
done_len:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_10_lex_ident_len ENDP
main PROC
    sub     rsp, 40
    call    ex_10_lex_ident_len
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
