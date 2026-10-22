; 17-floor-fixed.asm: Floor Q16.16 (clear frac bits), exit int
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_floor_fixed:PROC
main PROC
    ; TODO: implement ex_17_floor_fixed (student routine; defined in solutions/).
    call    ex_17_floor_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
