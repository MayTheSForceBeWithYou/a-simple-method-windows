; Exercise: 24-from-scratch-write-err
;
; FROM SCRATCH: write to invalid handle=-1; expect error; exit 1.
;
; Contract: implement `ex_24_from_scratch_write_err` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.DATA
message DB "Test"
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_24_from_scratch_write_err:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_write_err in this file.
    call    ex_24_from_scratch_write_err
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
