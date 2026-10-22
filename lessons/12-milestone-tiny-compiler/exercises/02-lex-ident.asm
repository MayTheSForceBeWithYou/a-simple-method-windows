; 02-lex-ident.asm: Test if byte is lowercase letter ('a'..'z'), exit 1 if true
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_lex_ident:PROC
main PROC
    ; TODO: write ex_02_lex_ident in this file.
    call    ex_02_lex_ident
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
