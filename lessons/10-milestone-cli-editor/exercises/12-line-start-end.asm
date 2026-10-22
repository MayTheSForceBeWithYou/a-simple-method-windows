; 12-line-start-end.asm: Find line start (scan back for \n), exit line_start
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_line_start_end:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_12_line_start_end (student routine; defined in solutions/).
    call    ex_12_line_start_end
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
