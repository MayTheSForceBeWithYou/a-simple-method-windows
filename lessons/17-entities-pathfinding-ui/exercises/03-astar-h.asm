; 03-astar-h: astar h
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_astar_h:PROC
main PROC
    ; TODO: write ex_03_astar_h in this file.
    call    ex_03_astar_h
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
