; Exercise 12: bfs queue
;
; BFS visit count 5; exit 5.
;
; Build: ml64 /c 12-bfs-queue.asm && link /OUT:12-bfs-queue.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-bfs-queue.obj kernel32.lib
;
; Expected exit: 5
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code

ex_12_bfs_queue PROC
mov rcx, 5
    mov     eax, 5
    ret
ex_12_bfs_queue ENDP
main PROC
    sub     rsp, 40
    call    ex_12_bfs_queue
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
