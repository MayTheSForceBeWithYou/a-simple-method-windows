; 11-delete-forward.asm: Delete at cursor=1 in "ABC", exit len (2)
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov buf[0], 'A'
    mov buf[1], 'B'
    mov buf[2], 'C'
    mov len, 3
    mov cur, 1

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
