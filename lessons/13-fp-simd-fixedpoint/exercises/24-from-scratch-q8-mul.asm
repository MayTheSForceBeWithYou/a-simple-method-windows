; 24-from-scratch-q8-mul
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_q8_mul:PROC
main PROC
    ; TODO: write ex_24_from_scratch_q8_mul in this file.
    call    ex_24_from_scratch_q8_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
