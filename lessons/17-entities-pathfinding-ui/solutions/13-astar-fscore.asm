; Exercise 13: astar fscore
;
; f=g+h; g=3 h=4; exit 7.
;
; Build: ml64 /c 13-astar-fscore.asm && link /OUT:13-astar-fscore.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-astar-fscore.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rdi,3
    add rdi,4
    mov rax,60
    syscall

main ENDP
END
