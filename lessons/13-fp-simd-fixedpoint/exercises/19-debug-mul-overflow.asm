; 19-debug-mul-overflow.asm: Debug: fix Q16.16 mul overflow
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_mul_overflow:PROC
main PROC
    ; TODO: implement ex_19_debug_mul_overflow (student routine; defined in solutions/).
    call    ex_19_debug_mul_overflow
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
