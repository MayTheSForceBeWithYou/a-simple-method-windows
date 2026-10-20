; Exercise 03: cursor move
;
; cursor; move right then left; exit cursor 0.
;
; Build: ml64 /c 03-cursor-move.asm && link /OUT:03-cursor-move.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-cursor-move.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.data?
cursor QWORD ?

.code
main PROC
    sub rsp, 32
    
    mov QWORD PTR [cursor], 0
    inc QWORD PTR [cursor]
    dec QWORD PTR [cursor]
    
    mov rcx, [cursor]
    call ExitProcess
main ENDP
END
