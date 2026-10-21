; Listing rule: any rep movs* user must run cld before the op and before ret (DF clear at ABI entry/return only).
; Fill rectangle with color, exit 0
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
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
