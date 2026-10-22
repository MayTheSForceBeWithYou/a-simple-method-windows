; Exercise: 18-status-line-len
;
; Status encodes len=12; exit 12.
;
; Contract: implement `ex_18_status_line_len` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
statusBuf DB 64 DUP(?)
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_18_status_line_len:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_status_line_len in this file.
    call    ex_18_status_line_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
