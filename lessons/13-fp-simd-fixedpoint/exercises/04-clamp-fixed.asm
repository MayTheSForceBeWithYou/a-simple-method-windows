; 04-clamp-fixed.asm: Clamp value to [0, max], exit clamped
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_clamp_fixed:PROC
main PROC
    ; TODO: implement ex_04_clamp_fixed (student routine; defined in solutions/).
    call    ex_04_clamp_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
