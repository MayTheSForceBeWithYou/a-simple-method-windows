; 02-lexer-digit
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_lexer_digit:PROC
main PROC
    ; TODO: implement ex_02_lexer_digit (student routine; defined in solutions/).
    call    ex_02_lexer_digit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
