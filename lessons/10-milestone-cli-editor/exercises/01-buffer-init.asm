; 01-buffer-init.asm: Initialize buffer (len=0, cur=0), exit 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    .ERR <TODO: mov len, 0; mov cur, 0; xor ecx, ecx; call ExitProcess>
main ENDP
END
