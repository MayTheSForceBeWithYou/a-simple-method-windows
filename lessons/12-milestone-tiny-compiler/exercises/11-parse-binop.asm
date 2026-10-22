; 11-parse-binop.asm: Parse binary operator (+/*), return operator kind
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_parse_binop:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_parse_binop in this file.
    call    ex_11_parse_binop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
