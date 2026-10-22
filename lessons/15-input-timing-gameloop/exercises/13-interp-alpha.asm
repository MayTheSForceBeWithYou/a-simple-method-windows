; 13-interp-alpha: interp alpha
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_interp_alpha:PROC
main PROC
    ; TODO: implement ex_13_interp_alpha (student routine; defined in solutions/).
    call    ex_13_interp_alpha
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
