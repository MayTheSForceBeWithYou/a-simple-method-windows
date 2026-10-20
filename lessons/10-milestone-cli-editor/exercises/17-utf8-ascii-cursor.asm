; 17-utf8-ascii-cursor.asm: ASCII-only cursor movement (simple), exit cur
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov len, 5
    mov cur, 2
    .ERR <TODO: Move cur right (inc cur; clamp to len), exit cur>
main ENDP
END
