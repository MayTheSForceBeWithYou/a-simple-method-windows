; Copy sprite to framebuffer, exit 0
.DATA
sprite DD 1, 2, 3, 4
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub     rsp, 32
    lea rsi, sprite
    lea rdi, fb
    mov ecx, 4
    rep movsd
    xor ecx, ecx
    call ExitProcess
main ENDP
END
