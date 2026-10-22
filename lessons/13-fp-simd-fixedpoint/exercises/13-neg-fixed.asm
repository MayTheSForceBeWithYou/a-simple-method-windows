; 13-neg-fixed.asm: Negate Q16.16 value, exit result
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_neg_fixed:PROC
main PROC
    ; TODO: write ex_13_neg_fixed in this file.
    call    ex_13_neg_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
