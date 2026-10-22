; 13-astar-fscore: astar fscore
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_astar_fscore:PROC
main PROC
    ; TODO: implement ex_13_astar_fscore (student routine; defined in solutions/).
    call    ex_13_astar_fscore
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
