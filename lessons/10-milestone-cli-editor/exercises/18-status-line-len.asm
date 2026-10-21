; 18-status-line-len.asm: Format status (len, cur) as string, exit len
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
statusBuf DB 64 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov len, 42
    mov cur, 10
    mov ecx, DWORD PTR len
    call ExitProcess
main ENDP
END
