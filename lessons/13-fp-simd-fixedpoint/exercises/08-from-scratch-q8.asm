; 08-from-scratch-q8.asm: Q8.8 format: 8 int, 8 frac bits
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_q8:PROC
main PROC
    ; TODO: implement ex_08_from_scratch_q8 (student routine; defined in solutions/).
    call    ex_08_from_scratch_q8
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
