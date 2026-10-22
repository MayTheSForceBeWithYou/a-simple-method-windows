; 18-fixed-angle-step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_fixed_angle_step:PROC
main PROC
    ; TODO: implement ex_18_fixed_angle_step (student routine; defined in solutions/).
    call    ex_18_fixed_angle_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
