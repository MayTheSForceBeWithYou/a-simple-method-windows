; Exercise: 09-insert-at-cursor
;
; Buffer empty; cursor 0; insert "X"; len=1 cursor=1; exit cursor.
;
; Contract: implement `ex_09_insert_at_cursor` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_insert_at_cursor:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_insert_at_cursor in this file.
    call    ex_09_insert_at_cursor
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
