; Exercise 09: insert at cursor
;
; Buffer empty; cursor 0; insert "X"; len=1 cursor=1; exit cursor.
;
; Build: ml64 /c 09-insert-at-cursor.asm && link /OUT:09-insert-at-cursor.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-insert-at-cursor.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.data?
buf BYTE 64 DUP(?)
len QWORD ?
cur QWORD ?

.code

ex_09_insert_at_cursor PROC
sub rsp, 40
    
    mov QWORD PTR [len], 0
    mov QWORD PTR [cur], 0
    
    mov rcx, [cur]
    lea rdx, buf
    mov BYTE PTR [rdx+rcx], 'X'
    
    inc QWORD PTR [len]
    inc QWORD PTR [cur]
    mov     eax, 1
    ret
ex_09_insert_at_cursor ENDP
main PROC
    sub     rsp, 40
    call    ex_09_insert_at_cursor
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
