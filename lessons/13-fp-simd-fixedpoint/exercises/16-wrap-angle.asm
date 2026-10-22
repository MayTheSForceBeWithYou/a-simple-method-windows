; 16-wrap-angle.asm: Wrap angle modulo 360, exit wrapped
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_wrap_angle:PROC
main PROC
    ; TODO: implement ex_16_wrap_angle (student routine; defined in solutions/).
    call    ex_16_wrap_angle
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
