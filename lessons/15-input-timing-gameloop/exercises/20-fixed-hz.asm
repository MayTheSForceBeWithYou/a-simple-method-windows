; 20-fixed-hz: fixed hz
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_fixed_hz:PROC
main PROC
    ; TODO: implement ex_20_fixed_hz (student routine; defined in solutions/).
    call    ex_20_fixed_hz
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
