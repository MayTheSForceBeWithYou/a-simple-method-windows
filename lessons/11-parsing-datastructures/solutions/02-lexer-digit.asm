; Exercise 02: lexer digit
;
; If byte '7' is digit exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_02_lexer_digit PROC
    sub rsp, 40
    mov al, '7'
    cmp al, '0'
    jb not_digit
    cmp al, '9'
    ja not_digit
    mov rcx, 1
    jmp done
not_digit:
    xor rcx, rcx
done:
    mov     eax, 1
    add     rsp, 40
    ret
ex_02_lexer_digit ENDP
main PROC
    sub     rsp, 40
    call    ex_02_lexer_digit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
