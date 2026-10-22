; 10-token-buffer
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_token_buffer:PROC
main PROC
    ; TODO: write ex_10_token_buffer in this file.
    call    ex_10_token_buffer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
