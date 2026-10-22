; 15-lerp-fixed.asm: Linear interpolation Q16.16, exit result
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_lerp_fixed:PROC
main PROC
    ; TODO: write ex_15_lerp_fixed in this file.
    call    ex_15_lerp_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
