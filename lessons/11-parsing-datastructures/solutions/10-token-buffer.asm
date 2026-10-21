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
main PROC
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
    call ExitProcess
main ENDP
END
