; 24-from-scratch-kill-line.asm: Delete from cursor to newline, exit len
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov buf[0], 'A'
    mov buf[1], 'B'
    mov buf[2], 13
    mov buf[3], 10
    mov len, 4
    mov cur, 1
    .ERR <TODO: Find \n after cur, delete from cur to \n (leave \n), exit len>
main ENDP
END
