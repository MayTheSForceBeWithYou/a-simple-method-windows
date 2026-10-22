; 14-abs-fixed.asm: Absolute value Q16.16, exit abs
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_abs_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_abs_fixed in this file.
    call    ex_14_abs_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
