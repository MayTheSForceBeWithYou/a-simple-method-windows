; 03-astar-h: astar h
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_astar_h:PROC
main PROC
    ; TODO: implement ex_03_astar_h (student routine; defined in solutions/).
    call    ex_03_astar_h
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
