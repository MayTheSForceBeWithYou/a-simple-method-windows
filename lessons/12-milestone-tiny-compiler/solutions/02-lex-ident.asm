; Exercise 02: lex ident
;
; Accept first char alpha; 'a' -> 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
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
    call ExitProcess
main ENDP
END
