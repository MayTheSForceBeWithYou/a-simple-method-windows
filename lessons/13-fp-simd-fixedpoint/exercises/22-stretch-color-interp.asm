; 22-stretch-color-interp.asm: Color interpolation RGB Q16.16
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_color_interp:PROC
main PROC
    ; TODO: write ex_22_stretch_color_interp in this file.
    call    ex_22_stretch_color_interp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
