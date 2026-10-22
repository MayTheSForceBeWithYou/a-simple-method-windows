; 02-bfs-dist: bfs dist
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_bfs_dist:PROC
main PROC
    ; TODO: implement ex_02_bfs_dist (student routine; defined in solutions/).
    call    ex_02_bfs_dist
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
