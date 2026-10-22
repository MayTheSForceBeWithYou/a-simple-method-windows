; Exercise 10: token buffer
;
; Lexeme copy "let" into tok; len=3 exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
src BYTE "let", 0

.data?
tok BYTE 8 DUP(?)
n QWORD ?

.code
ex_10_token_buffer PROC
    sub rsp, 40
    lea rsi, src
    lea rdi, tok
    xor rcx, rcx
loop_copy:
    mov al, BYTE PTR [rsi+rcx]
    mov BYTE PTR [rdi+rcx], al
    test al, al
    jz done_copy
    inc rcx
    jmp loop_copy
done_copy:
    mov QWORD PTR [n], rcx
    mov     eax, 3
    add     rsp, 40
    ret
ex_10_token_buffer ENDP
main PROC
    sub     rsp, 40
    call    ex_10_token_buffer
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
