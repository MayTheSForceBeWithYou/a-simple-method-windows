; 02-bfs-dist: bfs dist
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_bfs_dist:PROC
main PROC
    ; TODO: write ex_02_bfs_dist in this file.
    call    ex_02_bfs_dist
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
