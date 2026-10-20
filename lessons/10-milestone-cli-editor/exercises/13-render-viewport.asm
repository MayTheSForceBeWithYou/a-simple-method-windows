; 13-render-viewport.asm: Write first N bytes of buffer to stdout, exit 0
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
    mov buf[0], 'V'
    mov len, 1
    .ERR <TODO: Write viewport (min(len, screensize)) to stdout, exit 0>
main ENDP
END
