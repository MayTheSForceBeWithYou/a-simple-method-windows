; Exercise: 19-overlapped-write
;
; Emulate pwrite via SetFilePointerEx+WriteFile on NUL: open, seek end, write. Exit 0 on success.
;
; Contract: implement `ex_19_overlapped_write` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
filename DB "NUL", 0
message DB "Test"
message_len EQU $ - message
bytesWritten DWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointer:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_19_overlapped_write:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_overlapped_write in this file.
    call    ex_19_overlapped_write
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
