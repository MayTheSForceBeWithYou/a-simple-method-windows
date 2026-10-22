; 13-sweep-hit-t: sweep hit t
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_sweep_hit_t:PROC
main PROC
    ; TODO: write ex_13_sweep_hit_t in this file.
    call    ex_13_sweep_hit_t
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
