; 23-stretch-sin-lut
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_sin_lut:PROC
main PROC
    ; TODO: write ex_23_stretch_sin_lut in this file.
    call    ex_23_stretch_sin_lut
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
