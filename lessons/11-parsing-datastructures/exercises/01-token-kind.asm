; 01-token-kind
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_token_kind:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_token_kind in this file.
    call    ex_01_token_kind
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
