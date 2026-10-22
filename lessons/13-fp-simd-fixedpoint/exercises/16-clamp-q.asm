; 16-clamp-q
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_clamp_q:PROC
main PROC
    ; TODO: implement ex_16_clamp_q (student routine; defined in solutions/).
    call    ex_16_clamp_q
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
