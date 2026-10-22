; 17-precedence
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_precedence:PROC
main PROC
    ; TODO: implement ex_17_precedence (student routine; defined in solutions/).
    call    ex_17_precedence
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
