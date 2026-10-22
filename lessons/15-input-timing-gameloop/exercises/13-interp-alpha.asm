; 13-interp-alpha: interp alpha
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_interp_alpha:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_interp_alpha in this file.
    call    ex_13_interp_alpha
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
