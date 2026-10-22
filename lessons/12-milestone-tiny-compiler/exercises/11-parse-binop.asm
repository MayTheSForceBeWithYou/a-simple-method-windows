; 11-parse-binop.asm: Parse binary operator (+/*), return operator kind
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_parse_binop:PROC
main PROC
    ; TODO: implement ex_11_parse_binop (student routine; defined in solutions/).
    call    ex_11_parse_binop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
