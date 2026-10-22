; Exercise: 01-write-only
;
; Review write; print 'io\n'; exit 0.
; Expected stdout: "io\n"
;
; Contract: implement `ex_01_write_only` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg1 DB "Hello", 13, 10
msg1_len EQU $ - msg1
msg2 DB "World", 13, 10
msg2_len EQU $ - msg2
bytesWritten DWORD ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_01_write_only:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_01_write_only in this file.
    call    ex_01_write_only
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
