; Listing rule: any rep movs* user must run cld before the op and before ret (DF clear at ABI entry/return only).
; Plot pixel at (x,y) in framebuffer, exit 0
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rax, fb
    mov DWORD PTR [rax], 0FFFFFFFFh
    xor ecx, ecx
    call ExitProcess
main ENDP
END
