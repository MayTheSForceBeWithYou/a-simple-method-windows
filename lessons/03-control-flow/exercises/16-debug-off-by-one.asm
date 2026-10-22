; Exercise: 16-debug-off-by-one
;
; BUG: loop sums 0..5 inclusive instead of 1..5. Fix in `ex_16_debug_off_by_one`; expected sum 15.
;
; Contract: implement `ex_16_debug_off_by_one` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_16_debug_off_by_one:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_debug_off_by_one in this file.
    call    ex_16_debug_off_by_one
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
