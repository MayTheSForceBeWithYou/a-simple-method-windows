; 05-render-line.asm: Write buffer to stdout, exit 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
written DWORD ?
.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    mov buf[0], 'H'
    mov buf[1], 'i'
    mov len, 2
    .ERR <TODO: GetStdHandle, WriteFile buf with len bytes, exit 0>
main ENDP
END
