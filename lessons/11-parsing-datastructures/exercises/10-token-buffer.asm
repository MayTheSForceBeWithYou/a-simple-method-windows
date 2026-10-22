; 10-token-buffer
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_token_buffer:PROC
main PROC
    ; TODO: implement ex_10_token_buffer (student routine; defined in solutions/).
    call    ex_10_token_buffer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
