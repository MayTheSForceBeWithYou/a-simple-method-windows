; 20-dot3
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_dot3:PROC
main PROC
    ; TODO: implement ex_20_dot3 (student routine; defined in solutions/).
    call    ex_20_dot3
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
