; 10-lex-ident-len.asm: Scan identifier "foo", exit length (3)
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_lex_ident_len:PROC
main PROC
    ; TODO: write ex_10_lex_ident_len in this file.
    call    ex_10_lex_ident_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
