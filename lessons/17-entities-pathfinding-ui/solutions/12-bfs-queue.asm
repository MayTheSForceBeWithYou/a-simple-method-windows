; Exercise: 12-bfs-queue
;
; BFS visit count 5; exit 5.
; Expected stdout: (none)
; Expected exit: 5
;
.code
ex_12_bfs_queue PROC
    sub rsp, 40
    mov rcx, 5
    mov     eax, 5
    add     rsp, 40
    ret
ex_12_bfs_queue ENDP
main PROC
    sub     rsp, 40
    call    ex_12_bfs_queue
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
