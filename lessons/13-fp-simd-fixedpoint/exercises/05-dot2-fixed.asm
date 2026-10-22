; 05-dot2-fixed.asm: Dot product 2D vectors in Q16.16
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_dot2_fixed:PROC
main PROC
    ; TODO: write ex_05_dot2_fixed in this file.
    call    ex_05_dot2_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
