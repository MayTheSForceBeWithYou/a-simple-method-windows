; Exercise: 09-write-stderr
;
; Write "error\n" to stderr (fd 2), exit 1.
;
; Contract: implement `ex_09_write_stderr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.DATA
msg DB "Error", 13, 10
msg_len EQU $ - msg

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_09_write_stderr:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_write_stderr in this file.
    call    ex_09_write_stderr
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
