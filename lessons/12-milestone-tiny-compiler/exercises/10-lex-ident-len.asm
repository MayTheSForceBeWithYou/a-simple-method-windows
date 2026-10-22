; 10-lex-ident-len.asm: Scan identifier "foo", exit length (3)
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_lex_ident_len:PROC
main PROC
    ; TODO: implement ex_10_lex_ident_len (student routine; defined in solutions/).
    call    ex_10_lex_ident_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
