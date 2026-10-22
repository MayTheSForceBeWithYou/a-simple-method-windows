; Exercise: 02-bfs-dist
;
; Grid BFS stub: dist to neighbor 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_02_bfs_dist PROC
    sub rsp, 40
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_02_bfs_dist ENDP
main PROC
    sub     rsp, 40
    call    ex_02_bfs_dist
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
