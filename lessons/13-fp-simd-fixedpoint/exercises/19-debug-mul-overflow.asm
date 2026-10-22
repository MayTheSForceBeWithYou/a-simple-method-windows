; 19-debug-mul-overflow.asm: Debug: fix Q16.16 mul overflow
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_mul_overflow:PROC
main PROC
    ; TODO: write ex_19_debug_mul_overflow in this file.
    call    ex_19_debug_mul_overflow
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
