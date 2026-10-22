; 20-dot3
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_dot3:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_dot3 in this file.
    call    ex_20_dot3
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
