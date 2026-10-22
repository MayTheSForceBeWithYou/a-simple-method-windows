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

ex_03_cursor_move PROC
mov QWORD PTR [cursor], 0
    inc QWORD PTR [cursor]
    dec QWORD PTR [cursor]
    
    mov rcx, [cursor]
    mov     eax, ecx
    ret
ex_03_cursor_move ENDP
main PROC
    sub     rsp, 40
    call    ex_03_cursor_move
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
