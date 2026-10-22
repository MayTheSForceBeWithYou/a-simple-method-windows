; Exercise: 12-debug-off-by-scale
;
; BUG: array of qwords indexed with *1 instead of *8. Fix; load index 1 value 20, exit.
;
; Contract: implement `ex_12_debug_off_by_scale` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 20
;
.DATA
arr QWORD 10, 20, 30

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_12_debug_off_by_scale:PROC

main PROC
    sub     rsp, 40
    ; BUG: see exercise description; implement fix in student routine.
    ; TODO: write ex_12_debug_off_by_scale in this file.
    call    ex_12_debug_off_by_scale
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
