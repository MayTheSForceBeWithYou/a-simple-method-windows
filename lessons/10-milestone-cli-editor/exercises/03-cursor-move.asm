; 03-cursor-move.asm: Move cursor right with clamping, exit cursor value
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
