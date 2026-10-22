; 08-from-scratch-token-buf
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_token_buf:PROC
main PROC
    ; TODO: implement ex_08_from_scratch_token_buf (student routine; defined in solutions/).
    call    ex_08_from_scratch_token_buf
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
