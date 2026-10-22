; 03-parse-let.asm: Check first byte is 'l' (simplified keyword test), exit 1 if match
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_parse_let:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_parse_let in this file.
    call    ex_03_parse_let
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
