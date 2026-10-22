; 12-vline: vline
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_vline:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_vline in this file.
    call    ex_12_vline
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
