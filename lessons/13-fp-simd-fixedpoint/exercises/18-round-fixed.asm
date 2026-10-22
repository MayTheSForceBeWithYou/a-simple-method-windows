; 18-round-fixed.asm: Round Q16.16 to nearest int, exit rounded
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_round_fixed:PROC
main PROC
    ; TODO: implement ex_18_round_fixed (student routine; defined in solutions/).
    call    ex_18_round_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
