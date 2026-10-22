; Exercise: 05-get-last-error-open
;
; On failed CreateFileA, exit with GetLastError (ERROR_FILE_NOT_FOUND=2).
;
; Contract: implement `ex_05_get_last_error_open` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.DATA
filename DB "C:\nope.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC
EXTRN ex_05_get_last_error_open:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_get_last_error_open in this file.
    call    ex_05_get_last_error_open
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
