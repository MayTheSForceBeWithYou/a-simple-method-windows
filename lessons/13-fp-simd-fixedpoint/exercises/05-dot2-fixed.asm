; 05-dot2-fixed.asm: Dot product 2D vectors in Q16.16
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_dot2_fixed:PROC
main PROC
    ; TODO: implement ex_05_dot2_fixed (student routine; defined in solutions/).
    call    ex_05_dot2_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
