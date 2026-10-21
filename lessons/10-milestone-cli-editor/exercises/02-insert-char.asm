; 02-insert-char.asm: Append 'A', exit with length (1)
.DATA?
buf DB 256 DUP(?)
len QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov len, 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
