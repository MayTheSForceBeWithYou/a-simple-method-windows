; 05-render-line.asm: Write buffer to stdout, exit 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
written DWORD ?
.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_05_render_line:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_05_render_line (student routine; defined in solutions/).
    call    ex_05_render_line
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
