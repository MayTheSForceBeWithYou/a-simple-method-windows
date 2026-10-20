; Exercise 09: lexer skip ws
;
; Skip spaces before digit in "  7"; exit value 7.
; Expected exit: 7

EXTERN ExitProcess:PROC

.data
s BYTE "  7", 0

.code
main PROC
    sub rsp, 32
    lea rsi, s
loop_skip:
    cmp BYTE PTR [rsi], ' '
    jne done_skip
    inc rsi
    jmp loop_skip
done_skip:
    movzx rcx, BYTE PTR [rsi]
    sub rcx, '0'
    call ExitProcess
main ENDP
END
