; 09-insert-at-cursor.asm: Insert 'X' at cursor=0 in empty buffer, exit 1
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
