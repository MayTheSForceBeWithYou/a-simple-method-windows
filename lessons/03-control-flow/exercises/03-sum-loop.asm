; Exercise: 03-sum-loop
;
; Implement `ex_03_sum_loop` in this file.
;
; Contract: implement `ex_03_sum_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 55
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_03_sum_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_sum_loop in this file.
    call    ex_03_sum_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
