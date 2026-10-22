; 12-vline: vline
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_vline:PROC
main PROC
    ; TODO: implement ex_12_vline (student routine; defined in solutions/).
    call    ex_12_vline
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
