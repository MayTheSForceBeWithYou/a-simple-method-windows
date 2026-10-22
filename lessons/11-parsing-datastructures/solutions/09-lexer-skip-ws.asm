; Exercise 09: lexer skip ws
;
; Skip spaces before digit in "  7"; exit value 7.
; Expected exit: 7

EXTERN ExitProcess:PROC

.data
s BYTE "  7", 0

.code
ex_09_lexer_skip_ws PROC
    sub rsp, 40
    lea rsi, s
loop_skip:
    cmp BYTE PTR [rsi], ' '
    jne done_skip
    inc rsi
    jmp loop_skip
done_skip:
    movzx rcx, BYTE PTR [rsi]
    sub rcx, '0'
    mov     eax, 7
    add     rsp, 40
    ret
ex_09_lexer_skip_ws ENDP
main PROC
    sub     rsp, 40
    call    ex_09_lexer_skip_ws
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
