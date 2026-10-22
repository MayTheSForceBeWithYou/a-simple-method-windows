; 10-q16-frac.asm: Two halves (0.5+0.5=1.0), exit 1
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_q16_frac:PROC
main PROC
    ; TODO: implement ex_10_q16_frac (student routine; defined in solutions/).
    call    ex_10_q16_frac
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
