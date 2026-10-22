; Exercise: 12-line-start-end
;
; In "ab\ncd" find line start for cur=4 (index of c)->3; exit 3.
;
; Contract: implement `ex_12_line_start_end` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_line_start_end:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_line_start_end in this file.
    call    ex_12_line_start_end
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
