; 01-token-kind
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_token_kind:PROC
main PROC
    ; TODO: implement ex_01_token_kind (student routine; defined in solutions/).
    call    ex_01_token_kind
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
