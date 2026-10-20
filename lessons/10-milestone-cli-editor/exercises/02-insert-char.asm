; 02-insert-char.asm: Append 'A', exit with length (1)
.DATA?
buf DB 256 DUP(?)
len QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov len, 0
    .ERR <TODO: mov rax, len; mov buf[rax], 'A'; inc len; mov ecx, DWORD PTR len; exit>
main ENDP
END
