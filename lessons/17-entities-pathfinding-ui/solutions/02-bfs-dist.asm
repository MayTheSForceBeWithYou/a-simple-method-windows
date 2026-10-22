; Exercise 02: bfs dist
;
; Grid BFS stub: dist to neighbor 1.
;
; Build: ml64 /c 02-bfs-dist.asm && link /OUT:02-bfs-dist.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-bfs-dist.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_02_bfs_dist PROC
sub rsp, 40
    mov     eax, 1
    ret
ex_02_bfs_dist ENDP
main PROC
    sub     rsp, 40
    call    ex_02_bfs_dist
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
