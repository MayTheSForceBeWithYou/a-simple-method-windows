; Exercise: 02-bfs-dist
;
; Exercise 02: bfs dist
; Grid BFS stub: dist to neighbor 1.
; Expected stdout: (none)
;
; Contract: implement `ex_02_bfs_dist` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 02-bfs-dist: bfs dist
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_bfs_dist:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_bfs_dist in this file.
    call    ex_02_bfs_dist
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
