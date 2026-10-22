; 13-astar-fscore: astar fscore
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_astar_fscore:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_astar_fscore in this file.
    call    ex_13_astar_fscore
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
