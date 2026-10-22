; 12-parse-paren.asm: Parse (1+2), return inner value 3
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_parse_paren:PROC
main PROC
    ; TODO: implement ex_12_parse_paren (student routine; defined in solutions/).
    call    ex_12_parse_paren
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
