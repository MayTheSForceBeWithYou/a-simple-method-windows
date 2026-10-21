; 10-insert-middle.asm: Insert 'B' at cursor=1 in "AC", exit 66 ('B')
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov buf[0], 'A'
    mov buf[1], 'C'
    mov len, 2
    mov cur, 1

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
