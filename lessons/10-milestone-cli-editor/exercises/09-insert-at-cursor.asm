; 09-insert-at-cursor.asm: Insert 'X' at cursor=0 in empty buffer, exit 1
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov len, 0
    mov cur, 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
