; 12-bfs-queue: bfs queue
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_bfs_queue:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_bfs_queue in this file.
    call    ex_12_bfs_queue
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
