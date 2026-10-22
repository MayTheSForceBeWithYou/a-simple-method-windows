; Exercise: 08-from-scratch-close
;
; FROM SCRATCH: open NUL (Windows null device) read-only; close handle; exit 0 on success.
;
; Contract: implement `ex_08_from_scratch_close` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_close:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_close in this file.
    call    ex_08_from_scratch_close
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
