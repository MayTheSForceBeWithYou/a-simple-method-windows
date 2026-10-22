; 01-fixed-mul.asm: Multiply Q16.16: 2.0 * 3.0, exit 6
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_fixed_mul:PROC
main PROC
    ; TODO: implement ex_01_fixed_mul (student routine; defined in solutions/).
    call    ex_01_fixed_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
