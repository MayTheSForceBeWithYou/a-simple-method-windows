; Exercise: 17-duplicate-handle
;
; Without DuplicateHandle: write to stdout; exit 0. Documents handle reuse.
; Expected stdout: "d\n"
;
; Contract: implement `ex_17_duplicate_handle` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
message DB "Dup test", 13, 10
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN ExitProcess:PROC
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ex_17_duplicate_handle:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_duplicate_handle in this file.
    call    ex_17_duplicate_handle
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
