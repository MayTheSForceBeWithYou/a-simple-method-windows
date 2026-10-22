; 13-render-viewport.asm: Write first N bytes of buffer to stdout, exit 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
written DWORD ?
.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_13_render_viewport:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_13_render_viewport (student routine; defined in solutions/).
    call    ex_13_render_viewport
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
