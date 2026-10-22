; 17-precedence
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_precedence:PROC
main PROC
    ; TODO: write ex_17_precedence in this file.
    call    ex_17_precedence
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
