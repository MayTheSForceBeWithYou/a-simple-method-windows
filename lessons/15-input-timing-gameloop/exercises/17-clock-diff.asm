; Exercise: 17-clock-diff
;
; t1-t0 = 40; exit 40.
; Expected stdout: (none)
;
; Contract: implement `ex_17_clock_diff` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 40
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_17_clock_diff:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_clock_diff in this file.
    call    ex_17_clock_diff
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
