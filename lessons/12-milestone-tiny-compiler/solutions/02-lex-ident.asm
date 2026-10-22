; Exercise 02: lex ident
;
; Accept first char alpha; 'a' -> 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_02_lex_ident PROC
    sub rsp, 40
    mov al, 'a'
    cmp al, 'a'
    jb not_alpha
    cmp al, 'z'
    ja not_alpha
    mov rcx, 1
    jmp done
not_alpha:
    xor rcx, rcx
done:
    mov     eax, 1
    add     rsp, 40
    ret
ex_02_lex_ident ENDP
main PROC
    call    ex_02_lex_ident
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
