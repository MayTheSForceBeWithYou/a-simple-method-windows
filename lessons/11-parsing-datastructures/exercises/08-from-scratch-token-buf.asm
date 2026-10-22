; 08-from-scratch-token-buf
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_token_buf:PROC
main PROC
    ; TODO: write ex_08_from_scratch_token_buf in this file.
    call    ex_08_from_scratch_token_buf
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
