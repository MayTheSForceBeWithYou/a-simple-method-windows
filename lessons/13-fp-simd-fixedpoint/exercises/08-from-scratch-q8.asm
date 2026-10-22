; 08-from-scratch-q8.asm: Q8.8 format: 8 int, 8 frac bits
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_q8:PROC
main PROC
    ; TODO: write ex_08_from_scratch_q8 in this file.
    call    ex_08_from_scratch_q8
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
