; 02-lexer-digit
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_lexer_digit:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_lexer_digit in this file.
    call    ex_02_lexer_digit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
