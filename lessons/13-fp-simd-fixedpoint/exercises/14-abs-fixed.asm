; 14-abs-fixed.asm: Absolute value Q16.16, exit abs
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_abs_fixed:PROC
main PROC
    ; TODO: implement ex_14_abs_fixed (student routine; defined in solutions/).
    call    ex_14_abs_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
