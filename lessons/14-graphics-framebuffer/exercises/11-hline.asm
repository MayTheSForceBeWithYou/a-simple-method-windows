; 11-hline: hline
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_hline:PROC
main PROC
    ; TODO: implement ex_11_hline (student routine; defined in solutions/).
    call    ex_11_hline
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
