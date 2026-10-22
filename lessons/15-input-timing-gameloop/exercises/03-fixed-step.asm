; 03-fixed-step: fixed step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_fixed_step:PROC
main PROC
    ; TODO: implement ex_03_fixed_step (student routine; defined in solutions/).
    call    ex_03_fixed_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
