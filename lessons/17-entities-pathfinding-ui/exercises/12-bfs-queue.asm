; Exercise: 12-bfs-queue
;
; BFS visit count 5; exit 5.
; Expected stdout: (none)
;
; Contract: implement `ex_12_bfs_queue` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_12_bfs_queue:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_bfs_queue in this file.
    call    ex_12_bfs_queue
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
