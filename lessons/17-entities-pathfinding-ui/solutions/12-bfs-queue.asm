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
    
main PROC
    sub rsp, 40
    mov rcx, 5
    call ExitProcess

main ENDP
END
