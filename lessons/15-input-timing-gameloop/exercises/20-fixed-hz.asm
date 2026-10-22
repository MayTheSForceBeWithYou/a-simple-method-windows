; 20-fixed-hz: fixed hz
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_fixed_hz:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_fixed_hz in this file.
    call    ex_20_fixed_hz
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
