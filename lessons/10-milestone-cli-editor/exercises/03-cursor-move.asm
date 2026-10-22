; Exercise: 03-cursor-move
;
; cursor; move right then left; exit cursor 0.
;
; Contract: implement `ex_03_cursor_move` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA?
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_cursor_move:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_cursor_move in this file.
    call    ex_03_cursor_move
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
