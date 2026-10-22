; Exercise: 09-write-len-check
;
; write "Z\n"; if written==2 exit 0 else 1.
; Expected stdout: "Z\n"
;
; Contract: implement `ex_09_write_len_check` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
message DB "Test", 13, 10
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_09_write_len_check:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_write_len_check in this file.
    call    ex_09_write_len_check
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
