; Exercise: 06-popcount-naive
;
; Popcount of 0b101101 = 4.
;
; Contract: implement `ex_06_popcount_naive` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_06_popcount_naive:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_popcount_naive in this file.
    call    ex_06_popcount_naive
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
