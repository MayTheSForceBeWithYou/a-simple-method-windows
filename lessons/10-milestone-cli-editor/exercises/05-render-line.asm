; Exercise: 05-render-line
;
; Print buffer 'ed\n'; exit 0.
; Expected stdout: "ed\n"
;
; Contract: implement `ex_05_render_line` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
written DWORD ?
.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_05_render_line:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_render_line in this file.
    call    ex_05_render_line
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
