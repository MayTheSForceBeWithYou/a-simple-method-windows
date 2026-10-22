; 09-lex-number.asm: Scan multi-digit number "42", exit 42
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_lex_number:PROC
main PROC
    ; TODO: implement ex_09_lex_number (student routine; defined in solutions/).
    call    ex_09_lex_number
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
