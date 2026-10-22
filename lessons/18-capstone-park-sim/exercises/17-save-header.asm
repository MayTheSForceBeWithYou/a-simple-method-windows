; 17-save-header: save header
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_save_header:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_save_header in this file.
    call    ex_17_save_header
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
