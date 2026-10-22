; Exercise: 16-qpc
;
; QueryPerformanceCounter into counter; exit 0 if successful.
;
; Contract: implement `ex_16_qpc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
counter QWORD ?

.CODE

EXTRN QueryPerformanceCounter:PROC
EXTRN ExitProcess:PROC
EXTRN ex_16_qpc:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_qpc in this file.
    call    ex_16_qpc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
