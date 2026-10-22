; 01-fixed-mul.asm: Multiply Q16.16: 2.0 * 3.0, exit 6
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_fixed_mul:PROC
main PROC
    ; TODO: write ex_01_fixed_mul in this file.
    call    ex_01_fixed_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
