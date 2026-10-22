; 12-bfs-queue: bfs queue
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_bfs_queue:PROC
main PROC
    ; TODO: implement ex_12_bfs_queue (student routine; defined in solutions/).
    call    ex_12_bfs_queue
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
