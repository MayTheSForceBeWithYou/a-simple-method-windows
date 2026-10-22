; Exercise: 01-buffer-init
;
; Allocate 64 byte buffer; store length 0 in len; exit len.
;
; Contract: implement `ex_01_buffer_init` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_01_buffer_init:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_buffer_init in this file.
    call    ex_01_buffer_init
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
