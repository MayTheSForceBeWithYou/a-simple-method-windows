; 16-wrap-angle.asm: Wrap angle modulo 360, exit wrapped
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_wrap_angle:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_wrap_angle in this file.
    call    ex_16_wrap_angle
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
