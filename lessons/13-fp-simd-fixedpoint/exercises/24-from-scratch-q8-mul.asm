; 24-from-scratch-q8-mul
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_q8_mul:PROC
main PROC
    ; TODO: implement ex_24_from_scratch_q8_mul (student routine; defined in solutions/).
    call    ex_24_from_scratch_q8_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
