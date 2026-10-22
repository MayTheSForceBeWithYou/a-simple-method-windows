; Exercise 09: lex number
;
; Parse "42" into int; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data
s BYTE "42", 0

.code

ex_09_lex_number PROC
lea rsi, s
    xor rcx, rcx
loop_parse:
    movzx rax, BYTE PTR [rsi]
    test rax, rax
    jz done_parse
    sub rax, '0'
    imul rcx, 10
    add rcx, rax
    inc rsi
    jmp loop_parse
done_parse:
    mov     eax, 42
    ret
ex_09_lex_number ENDP
main PROC
    sub     rsp, 40
    call    ex_09_lex_number
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
