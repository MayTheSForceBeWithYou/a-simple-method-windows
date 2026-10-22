; 24-from-scratch-normalize2.asm: Normalize 2D vector, exit length
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_normalize2:PROC
main PROC
    ; TODO: write ex_24_from_scratch_normalize2 in this file.
    call    ex_24_from_scratch_normalize2
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
