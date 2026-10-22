; 16-clamp-q
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_clamp_q:PROC
main PROC
    ; TODO: write ex_16_clamp_q in this file.
    call    ex_16_clamp_q
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
