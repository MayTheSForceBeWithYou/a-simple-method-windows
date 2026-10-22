; 11-hline: hline
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_hline:PROC
main PROC
    ; TODO: write ex_11_hline in this file.
    call    ex_11_hline
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
