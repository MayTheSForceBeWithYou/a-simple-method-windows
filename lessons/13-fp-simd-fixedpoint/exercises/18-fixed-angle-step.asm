; 18-fixed-angle-step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_fixed_angle_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_fixed_angle_step in this file.
    call    ex_18_fixed_angle_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
