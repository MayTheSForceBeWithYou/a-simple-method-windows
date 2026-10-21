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
main PROC
    sub rsp, 40
    mov rcx, 1
    call ExitProcess
main ENDP
END
