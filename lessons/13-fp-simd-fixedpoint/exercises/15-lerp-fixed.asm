; 15-lerp-fixed.asm: Linear interpolation Q16.16, exit result
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_lerp_fixed:PROC
main PROC
    ; TODO: implement ex_15_lerp_fixed (student routine; defined in solutions/).
    call    ex_15_lerp_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
