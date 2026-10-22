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
    ; TODO: write ex_18_status_line_len in this file.
    call    ex_18_status_line_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
