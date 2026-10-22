; Exercise: 17-utf8-ascii-cursor
;
; ASCII-only: moving right increments cursor by 1; exit 5 after 5 moves.
;
; Contract: implement `ex_17_utf8_ascii_cursor` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_utf8_ascii_cursor:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_utf8_ascii_cursor in this file.
    call    ex_17_utf8_ascii_cursor
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
