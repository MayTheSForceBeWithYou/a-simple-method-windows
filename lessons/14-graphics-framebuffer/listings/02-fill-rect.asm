; Fill rectangle with color, exit 0
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    lea rdi, fb
    mov ecx, 100
fill_loop:
    mov DWORD PTR [rdi], 0FF0000FFh
    add rdi, 4
    loop fill_loop
    xor ecx, ecx
    call ExitProcess
main ENDP
END
