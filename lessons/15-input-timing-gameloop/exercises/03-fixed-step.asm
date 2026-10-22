; 03-fixed-step: fixed step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_fixed_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_fixed_step in this file.
    call    ex_03_fixed_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
