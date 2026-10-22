; Exercise: 10-open-nul
;
; open NUL (Windows null device) write-only; on success close and exit 0.
;
; Contract: implement `ex_10_open_nul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_10_open_nul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_open_nul in this file.
    call    ex_10_open_nul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
