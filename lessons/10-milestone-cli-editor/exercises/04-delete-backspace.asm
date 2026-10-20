; 04-delete-backspace.asm: Backspace at end (dec len), exit len
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov buf[0], 'A'
    mov buf[1], 'B'
    mov len, 2
    mov cur, 2
    .ERR <TODO: Check cur>0; dec len; dec cur; exit len>
main ENDP
END
