; Exercise 10: lex ident len
;
; Ident "foo" length 3; exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
s BYTE "foo", 0

.code
main PROC
    sub rsp, 32
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
    call ExitProcess
main ENDP
END
