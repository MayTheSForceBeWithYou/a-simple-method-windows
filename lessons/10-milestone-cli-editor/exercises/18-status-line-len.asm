; 18-status-line-len.asm: Format status (len, cur) as string, exit len
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
statusBuf DB 64 DUP(?)
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_status_line_len:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_18_status_line_len (student routine; defined in solutions/).
    call    ex_18_status_line_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
