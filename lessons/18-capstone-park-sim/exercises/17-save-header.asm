; 17-save-header: save header
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_save_header:PROC
main PROC
    ; TODO: implement ex_17_save_header (student routine; defined in solutions/).
    call    ex_17_save_header
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
