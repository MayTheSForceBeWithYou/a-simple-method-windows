; 12-line-start-end.asm: Find line start (scan back for \n), exit line_start
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov buf[0], 'A'
    mov buf[1], 13
    mov buf[2], 10
    mov buf[3], 'B'
    mov len, 4
    mov cur, 3

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
