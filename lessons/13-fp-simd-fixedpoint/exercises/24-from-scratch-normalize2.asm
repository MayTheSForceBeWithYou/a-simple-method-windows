; 24-from-scratch-normalize2.asm: Normalize 2D vector, exit length
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_normalize2:PROC
main PROC
    ; TODO: implement ex_24_from_scratch_normalize2 (student routine; defined in solutions/).
    call    ex_24_from_scratch_normalize2
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
