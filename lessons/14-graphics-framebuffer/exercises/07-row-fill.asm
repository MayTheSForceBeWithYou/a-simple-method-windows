; 07-row-fill: row fill
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_row_fill:PROC
main PROC
    ; TODO: write ex_07_row_fill in this file.
    call    ex_07_row_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
