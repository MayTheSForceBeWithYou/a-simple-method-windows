; 17-utf8-ascii-cursor.asm: ASCII-only cursor movement (simple), exit cur
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_utf8_ascii_cursor:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_utf8_ascii_cursor in this file.
    call    ex_17_utf8_ascii_cursor
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
